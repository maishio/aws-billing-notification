import json
import os
from datetime import date, datetime, timedelta

import boto3
import requests
from notify_aws_billing.config.logger import logger

SLACK_WEBHOOK_URL = os.environ["SLACK_WEBHOOK_URL"]


def lambda_handler(event, context) -> None:
    client = boto3.client("ce", region_name="us-east-1")

    # get total and service-wise billing amounts
    total_billing = get_total_billing(client)
    service_billings = get_service_billings(client)

    # create and throw messages for Slack
    (title, detail) = get_message(total_billing, service_billings)
    post_slack(title, detail)


def get_total_billing(client) -> dict:
    (start_date, end_date) = get_total_cost_date_range()

    # fmt: off
    response = client.get_cost_and_usage(
        TimePeriod = {
            "Start": start_date,
            "End": end_date
        },
        Granularity = "MONTHLY",
        Metrics = [
            "AmortizedCost"
        ]
    )
    # fmt: on

    return {
        "start": response["ResultsByTime"][0]["TimePeriod"]["Start"],
        "end": response["ResultsByTime"][0]["TimePeriod"]["End"],
        "billing": response["ResultsByTime"][0]["Total"]["AmortizedCost"]["Amount"],
    }


def get_service_billings(client) -> list:
    (start_date, end_date) = get_total_cost_date_range()

    # fmt: off
    response = client.get_cost_and_usage(
        TimePeriod = {
            "Start": start_date,
            "End": end_date
        },
        Granularity = "MONTHLY",
        Metrics = [
            "AmortizedCost"
        ],
        GroupBy = [
            {
                "Type": "DIMENSION",
                "Key": "SERVICE"
            }
        ]
    )
    # fmt: on

    billings = []
    for item in response["ResultsByTime"][0]["Groups"]:
        billing = round(float(item["Metrics"]["AmortizedCost"]["Amount"]), 2)
        if billing == 0.0:
            continue
        billings.append({"service_name": item["Keys"][0], "billing": billing})
    # sort by billing in descending order
    sorted_billings = sorted(billings, key=lambda x: x["billing"], reverse=True)
    return sorted_billings


def get_message(total_billing: dict, service_billings: list) -> tuple[str, str]:
    start = datetime.strptime(total_billing["start"], "%Y-%m-%d").strftime("%m/%d")

    end_today = datetime.strptime(total_billing["end"], "%Y-%m-%d")
    end_yesterday = (end_today - timedelta(days=1)).strftime("%m/%d")

    total = round(float(total_billing["billing"]), 2)

    # Call the GetCallerIdentity API to get the AWS account ID
    sts_client = boto3.client("sts")
    account_id = sts_client.get_caller_identity()["Account"]

    title = f"[{account_id}] Billing amount from {start} to {end_yesterday} is {total} USD."

    details = []
    for item in service_billings:
        service_name = item["service_name"]
        billing = item["billing"]
        details.append(f"  ・{service_name}: {billing:.2f} USD")

    return title, "\n".join(details)


def post_slack(title: str, detail: str) -> None:
    # fmt: off
    payload = {
        "attachments": [
            {
                "color": "#36a64f",
                "pretext": title,
                "text": detail
            }
        ]
    }
    # fmt: on

    try:
        requests.post(SLACK_WEBHOOK_URL, data=json.dumps(payload))
    except Exception as e:
        logger.exception(f"message: {e}")


def get_total_cost_date_range() -> tuple[str, str]:
    start_date = date.today().replace(day=1).isoformat()
    end_date = date.today().isoformat()
    if start_date == end_date:
        end_of_month = datetime.strptime(start_date, "%Y-%m-%d") + timedelta(days=-1)
        start_date = end_of_month.replace(day=1).date().isoformat()
    return start_date, end_date


if __name__ == "__main__":
    lambda_handler({}, {})

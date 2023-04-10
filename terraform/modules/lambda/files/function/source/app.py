import boto3
import json
import os

from datetime import datetime, timedelta, date
from config.logger import logger
from config.teams import Teams


def lambda_handler(event, context) -> None:
    try:
        # Initialize boto3 client
        client = boto3.client('ce')

        # Get total and service-wise billing amounts
        total_billing = get_total_billing(client)
        service_billings = get_service_billings(client)

        # Prepare message to be sent to Teams
        (title, detail) = get_message(total_billing, service_billings)
        post_teams(title, detail, service_billings)
    except Exception as e:
        logger.exception(f"message: {e}")


def get_total_billing(client) -> dict:
    start_date, end_date = get_total_cost_date_range()

    response = client.get_cost_and_usage(
        TimePeriod={
            'Start': start_date,
            'End': end_date
        },
        Granularity='MONTHLY',
        Metrics=[
            'AmortizedCost'
        ]
    )
    return {
        'start': response['ResultsByTime'][0]['TimePeriod']['Start'],
        'end': response['ResultsByTime'][0]['TimePeriod']['End'],
        'billing': round(float(response['ResultsByTime'][0]['Total']['AmortizedCost']['Amount']), 2),
    }


def get_service_billings(client) -> list:
    start_date, end_date = get_total_cost_date_range()

    response = client.get_cost_and_usage(
        TimePeriod={
            'Start': start_date,
            'End': end_date
        },
        Granularity='MONTHLY',
        Metrics=[
            'AmortizedCost'
        ],
        GroupBy=[
            {
                'Type': 'DIMENSION',
                'Key': 'SERVICE'
            }
        ]
    )

    billings = []
    for item in response['ResultsByTime'][0]['Groups']:
        billing = round(float(item['Metrics']['AmortizedCost']['Amount']), 2)
        if billing == 0.0:
            continue
        billings.append({
            'service_name': item['Keys'][0],
            'billing': billing
        })
    return billings


def get_message(total_billing: dict, service_billings: list) -> (str, str):
    start = datetime.strptime(total_billing['start'], '%Y-%m-%d').strftime('%m/%d')
    end_yesterday = (datetime.strptime(total_billing['end'], '%Y-%m-%d') - timedelta(days=1)).strftime('%m/%d')
    total = total_billing['billing']
    title = f'{start}～{end_yesterday}の請求額は、{total:.2f} USDです。'

    details = []
    for item in service_billings:
        service_name = item['service_name']
        billing = item['billing']
        details.append(f'　・{service_name}: {billing:.2f} USD')

    return title, '\n'.join(details)


def post_teams(title: str, detail: str, service_billings: list) -> None:
    teams_web_url = os.environ['TEAMS_WEBHOOK_URL']

    facts = []
    for billing in service_billings:
        service_name = billing['service_name']
        billing = round(float(billing['billing']), 2)

        # 請求金額が0.0のサービスは通知から除外する
        if billing == 0.0:
            continue

        service = {'name': f'{billing:.2f} USD', 'value': service_name, 'billing': billing}
        logger.info(f'service: {service}')
        facts.append(service)

    facts_sorted_by_billing = sorted(facts, key=lambda x: x['billing'], reverse=True)

    # ソート用に保持していたbilling要素を削除
    for item in facts_sorted_by_billing:
        del item['billing']

    payload = {
        '@type': 'MessageCard',
        "@context": "http://schema.org/extensions",
        "themeColor": "0076D7",
        "summary": title,
        "sections": [{
            "activityTitle": title,
            "activitySubtitle": "サービス別利用金額(金額降順)",
            "activityImage": "https://img.icons8.com/color/50/000000/amazon-web-services.png",
            "facts": facts_sorted_by_billing,
            "markdown": 'true'
        }]
    }

    teams = Teams(teams_web_url)
    response = teams.post(json.dumps(payload))
    logger.info(f'Teamsコスト通知連携ステータスコード: {response.status_code}')


def get_total_cost_date_range() -> (str, str):
    start_date = date.today().replace(day=1).isoformat()
    end_date = date.today().isoformat()
    if start_date == end_date:
        end_of_month = datetime.strptime(start_date, '%Y-%m-%d') + timedelta(days=-1)
        start_date = end_of_month.replace(day=1).date().isoformat()
    return start_date, end_date

import boto3
import json
import os
import requests

from datetime import datetime, timedelta, date
from config.logger import logger
from config.teams import Teams

client = boto3.client('ce')


def lambda_handler(event, context) -> None:
    try:
        # 合計とサービス毎の請求額を取得する
        total_billing = get_total_billing(client)
        service_billings = get_service_billings(client)

        # Teamsに送信するメッセージを作成げる
        (title, detail) = get_message(total_billing, service_billings)

        post_teams(title, detail, service_billings)
    except Exception as e:
        logger.exception(f"message: {e}")


def get_total_billing(client) -> dict:
    try:
        (start_date, end_date) = get_total_cost_date_range()

        # https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/ce.html#CostExplorer.Client.get_cost_and_usage
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
            'billing': response['ResultsByTime'][0]['Total']['AmortizedCost']['Amount'],
        }
    except Exception as e:
        raise Exception(str(e))


def get_service_billings(client) -> list:
    try:
        (start_date, end_date) = get_total_cost_date_range()

        # https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/ce.html#CostExplorer.Client.get_cost_and_usage
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
            billings.append({
                'service_name': item['Keys'][0],
                'billing': item['Metrics']['AmortizedCost']['Amount']
            })
        return billings
    except Exception as e:
        raise Exception(str(e))


def get_message(total_billing: dict, service_billings: list) -> (str, str):
    try:
        start = datetime.strptime(total_billing['start'], '%Y-%m-%d').strftime('%m/%d')

        # Endの日付は結果に含まないため、表示上は前日にしておく
        end_today = datetime.strptime(total_billing['end'], '%Y-%m-%d')
        end_yesterday = (end_today - timedelta(days=1)).strftime('%m/%d')

        total = round(float(total_billing['billing']), 2)

        title = f'{start}～{end_yesterday}の請求額は、{total:.2f} USDです。'

        details = []
        for item in service_billings:
            service_name = item['service_name']
            billing = round(float(item['billing']), 2)

            if billing == 0.0:
                # 請求無し（0.0 USD）の場合は、内訳を表示しない
                continue
            details.append(f'　・{service_name}: {billing:.2f} USD')

        return title, '\n'.join(details)
    except Exception as e:
        raise Exception(str(e))

def post_teams(title: str, detail: str, service_billings: list) -> None:
    try:
        # Lambda関数の環境変数からTEAMS_WEBHOOK_URLの値を取得
        teams_web_url = os.environ['TEAMS_WEBHOOK_URL']

        facts = []
        for billing in service_billings:
            service_name = billing['service_name']
            billing = round(float(billing['billing']), 2)

            # 請求金額が0.0のサービスは通知から除外する
            if billing == 0.0:
                continue

            service = {'name': f'{billing:.2f} USD', 'value':service_name, 'billing':billing}
            logger.info(f'service：{service}')

            facts.append(service)

        facts_sorted_by_billing = sorted(facts, key=lambda x:x['billing'], reverse=True)

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

        logger.info(f'Teamsコスト通知連携ステータスコード：{response.status_code}')
    except Exception as err:
        raise Exception(str(err))

def get_total_cost_date_range() -> (str, str):
    try:
        start_date = get_begin_of_month()
        end_date = get_today()

        # get_cost_and_usage()のstartとendに同じ日付は指定不可のため、
        # 「今日が1日」なら、「先月1日から今月1日（今日）」までの範囲にする
        if start_date == end_date:
            end_of_month = datetime.strptime(start_date, '%Y-%m-%d') + timedelta(days=-1)
            begin_of_month = end_of_month.replace(day=1)
            return begin_of_month.date().isoformat(), end_date
        return start_date, end_date
    except Exception as e:
        raise Exception(str(e))

def get_begin_of_month() -> str:
    return date.today().replace(day=1).isoformat()


def get_prev_day(prev: int) -> str:
    return (date.today() - timedelta(days=prev)).isoformat()


def get_today() -> str:
    return date.today().isoformat()

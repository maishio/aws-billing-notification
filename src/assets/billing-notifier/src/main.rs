use aws_config::BehaviorVersion;
use aws_sdk_costexplorer::{Client, types::{DateInterval, Granularity, GroupDefinition, GroupDefinitionType}};
use chrono::{DateTime, Utc, Datelike, NaiveDate};
use lambda_runtime::{run, service_fn, LambdaEvent};
use serde_json::Value;
use tracing::info;
use tracing_bunyan_formatter::{BunyanFormattingLayer, JsonStorageLayer};
use tracing_subscriber::{layer::SubscriberExt, EnvFilter, Registry};

#[derive(Debug, Default)]
struct Billing {
    start: String,
    end: String,
    amount: String,
    unit: String,
}

impl Billing {
    pub fn set_time_period(&mut self, start: String, end: String) {
        self.start = start;
        self.end = end;
    }

    pub fn set_amortized_cost(&mut self, amount: String, unit: String) {
        self.amount = amount;
        self.unit = unit;
    }
}

# [derive(Debug, Default)]
struct BillingByService {
    service: String,
    amount: String,
}

impl BillingByService {
    pub fn set_billing_by_service(&mut self, service: String, amount: String) {
        self.service = service;
        self.amount = amount;
    }
}

async fn handler(_event: LambdaEvent<Value>) -> Result<(), lambda_runtime::Error> {
    let config = aws_config::load_defaults(BehaviorVersion::latest()).await;
    let client = Client::new(&config);
    // let _slack_webhook_url = env::var("SLACK_WEBHOOK_URL").expect("🔥 SLACK_WEBHOOK_URL must be set");

    let (start_date, end_date) = get_date_range().await;
    get_total_billing(&client, &start_date, &end_date).await?;
    get_billing_by_service(&client, &start_date, &end_date).await?;

    Ok(())
}

async fn get_date_range() -> (String, String) {
    let utc_now: DateTime<Utc> = Utc::now();
    let start_date  = NaiveDate::from_ymd_opt(utc_now.year(), utc_now.month(), 1).unwrap().format("%Y-%m-%d").to_string();
    let end_date = NaiveDate::from_ymd_opt(utc_now.year(), utc_now.month(), utc_now.day()).unwrap().format("%Y-%m-%d").to_string();

    let start_date = if start_date == end_date {
        NaiveDate::from_ymd_opt(utc_now.year(), utc_now.month() - 1, 1).unwrap().format("%Y-%m-%d").to_string()
    } else {
        start_date
    };
    info!("Start Date: {}", start_date);
    info!("End Date: {}", end_date);

    (start_date, end_date)
}

async fn get_total_billing(client: &Client, start_date: &String, end_date: &String) -> Result<(), aws_sdk_costexplorer::Error> {
    let response = client.get_cost_and_usage()
        .time_period(DateInterval::builder().start(start_date).end(end_date).build()?)
        .granularity(Granularity::Monthly)
        .metrics("AmortizedCost")
        .send()
        .await?;

    // responseの中身
    // GetCostAndUsageOutput { next_page_token: None, group_definitions: None, results_by_time: Some([ResultByTime { time_period: Some(DateInterval { start: \"2024-04-01\", end: \"2024-05-01\" }), total: Some({\"AmortizedCost\": MetricValue { amount: Some(\"2.2456036778\"), unit: Some(\"USD\") }}), groups: Some([]), estimated: true }]), dimension_value_attributes: Some([]), _request_id: Some(\"35cfcfa7-7765-4cfd-a832-cd04728fdf83\") }

    let mut billings:Vec<Billing> =vec![];

    if let Some(results_by_time) = response.results_by_time{
        results_by_time.iter().for_each(|result| {

            let mut billing = Billing::default();

            if let Some(time_period) = &result.time_period {
                billing.set_time_period(time_period.start.clone(), time_period.end.clone());
            }

            if let Some(total) = &result.total {
                let amortized_cost = total.get("AmortizedCost").unwrap();
                let amount = amortized_cost.amount().unwrap_or("unknown").to_string();
                let unit = amortized_cost.unit().unwrap_or("unknown").to_string();
                billing.set_amortized_cost(amount.clone(), unit.clone());
            }
            billings.push(billing);
        });
    }
    for billing in billings {
        info!("billing: {:?}", billing);
    }
    Ok(())
}
 
async fn get_billing_by_service(client: &Client, start_date: &String, end_date: &String) -> Result<(), aws_sdk_costexplorer::Error> {
    let group_definition = GroupDefinition::builder()
        .key("SERVICE")
        .set_type(Some(GroupDefinitionType::Dimension))
        .build();

    let response = client.get_cost_and_usage()
        .time_period(DateInterval::builder().start(start_date).end(end_date).build()?)
        .granularity(Granularity::Monthly)
        .metrics("AmortizedCost")
        .group_by(group_definition)
        .send()
        .await?;

    // responseの中身
    // Response: GetCostAndUsageOutput { next_page_token: None, group_definitions: Some([GroupDefinition { type: Some(Dimension), key: Some(\"SERVICE\") }]), results_by_time: Some([ResultByTime { time_period: Some(DateInterval { start: \"2024-05-01\", end: \"2024-05-05\" }), total: Some({}), groups: Some([Group { keys: Some([\"AWS Amplify\"]), metrics: Some({\"AmortizedCost\": MetricValue { amount: Some(\"0.0000001763\"), unit: Some(\"USD\") }}) }, Group { keys: Some([\"AWS CloudTrail\"]), metrics: Some({\"AmortizedCost\": MetricValue { amount: Some(\"0\"), unit: Some(\"USD\") }}) }, Group { keys: Some([\"AWS Cost Explorer\"]), metrics: Some({\"AmortizedCost\": MetricValue { amount: Some(\"0.17\"), unit: Some(\"USD\") }}) }, Group { keys: Some([\"AWS Glue\"]), metrics: Some({\"AmortizedCost\": MetricValue { amount: Some(\"0\"), unit: Some(\"USD\") }}) }, Group { keys: Some([\"AWS Key Management Service\"]), metrics: Some({\"AmortizedCost\": MetricValue { amount: Some(\"0\"), unit: Some(\"USD\") }}) }, Group { keys: Some([\"AWS Lambda\"]), metrics: Some({\"AmortizedCost\": MetricValue { amount: Some(\"0\"), unit: Some(\"USD\") }}) }, Group { keys: Some([\"AWS Secrets Manager\"]), metrics: Some({\"AmortizedCost\": MetricValue { amount: Some(\"0.1549187072\"), unit: Some(\"USD\") }}) }, Group { keys: Some([\"Amazon API Gateway\"]), metrics: Some({\"AmortizedCost\": MetricValue { amount: Some(\"0.000073\"), unit: Some(\"USD\") }}) }, Group { keys: Some([\"Amazon DynamoDB\"]), metrics: Some({\"AmortizedCost\": MetricValue { amount: Some(\"0.000008375\"), unit: Some(\"USD\") }}) }, Group { keys: Some([\"Amazon EC2 Container Registry (ECR)\"]), metrics: Some({\"AmortizedCost\": MetricValue { amount: Some(\"0.0085738065\"), unit: Some(\"USD\") }}) }, Group { keys: Some([\"EC2 - Other\"]), metrics: Some({\"AmortizedCost\": MetricValue { amount: Some(\"0.09\"), unit: Some(\"USD\") }}) }, Group { keys: Some([\"Amazon Elastic Compute Cloud - Compute\"]), metrics: Some({\"AmortizedCost\": MetricValue { amount: Some(\"0\"), unit: Some(\"USD\") }}) }, Group { keys: Some([\"Amazon Route 53\"]), metrics: Some({\"AmortizedCost\": MetricValue { amount: Some(\"0.5002472\"), unit: Some(\"USD\") }}) }, Group { keys: Some([\"Amazon Simple Queue Service\"]), metrics: Some({\"AmortizedCost\": MetricValue { amount: Some(\"0\"), unit: Some(\"USD\") }}) }, Group { keys: Some([\"Amazon Simple Storage Service\"]), metrics: Some({\"AmortizedCost\": MetricValue { amount: Some(\"0.0181355331\"), unit: Some(\"USD\") }}) }, Group { keys: Some([\"Amazon Virtual Private Cloud\"]), metrics: Some({\"AmortizedCost\": MetricValue { amount: Some(\"0.000929165\"), unit: Some(\"USD\") }}) }, Group { keys: Some([\"AmazonCloudWatch\"]), metrics: Some({\"AmortizedCost\": MetricValue { amount: Some(\"0\"), unit: Some(\"USD\") }}) }, Group { keys: Some([\"Tax\"]), metrics: Some({\"AmortizedCost\": MetricValue { amount: Some(\"0.1\"), unit: Some(\"USD\") }}) }]), estimated: true }]), dimension_value_attributes: Some([]), _request_id: Some(\"48a5b7bf-03c0-424d-80fa-b82afcc38554\") }"

    let mut billing_by_services:Vec<BillingByService> =vec![];

    if let Some(results_by_time) = response.results_by_time {
        results_by_time.iter().for_each(|result| {
            if let Some(groups) = &result.groups {
                groups.iter().for_each(|group| {
                    if let (Some(keys), Some(metrics)) = (&group.keys, &group.metrics) {
                        let amortized_cost = metrics.get("AmortizedCost").unwrap();
                        let key = keys.first().unwrap();
                        let amount = amortized_cost.amount().unwrap_or("unknown").to_string();

                        let mut billing_by_service = BillingByService::default();
                        billing_by_service.set_billing_by_service(key.clone(), amount.clone());
                        billing_by_services.push(billing_by_service);
                    }
                });
            }
        });
    }
    for billing_by_service in billing_by_services {
        info!("billing_by_service: {:?}", billing_by_service);
    }

    Ok(())
}

#[tokio::main]
async fn main() -> Result<(), lambda_runtime::Error> {
    init_tracer();
    run(service_fn(handler)).await?;
    Ok(())
}

fn init_tracer(){
    let env_filter = EnvFilter::try_from_default_env().unwrap_or(EnvFilter::new("info"));
    let formatting_layer = BunyanFormattingLayer::new("billing_notifier".into(), std::io::stdout);
    let subscriber = Registry::default()
        .with(env_filter)
        .with(formatting_layer)
        .with(JsonStorageLayer);

    tracing::subscriber::set_global_default(subscriber).expect("Failed to set tracing subscriber");
}

mod ce;

use chrono::{DateTime, Utc, Datelike, NaiveDate};
use lambda_runtime::{run, service_fn, Error, LambdaEvent};
use serde_json::Value;
use tracing::info;
use tracing_bunyan_formatter::{BunyanFormattingLayer, JsonStorageLayer};
use tracing_subscriber::{layer::SubscriberExt, EnvFilter, Registry};

use ce::get_cost_and_usage_by_service;

async fn handler(_event: LambdaEvent<Value>) -> Result<(), Error> {
    let (start_date, end_date) = get_date_range().await;
    let mut cost_and_usages = get_cost_and_usage_by_service(&start_date, &end_date).await?;

    cost_and_usages.retain(|x| x.amount() != 0.0);
    cost_and_usages.sort_by(|a, b| b.amount().partial_cmp(&a.amount()).unwrap());
    cost_and_usages.iter().for_each(|x| {x.debug();});
    Ok(())
}

async fn get_date_range() -> (String, String) {
    let utc_now: DateTime<Utc> = Utc::now();
    let start_date  = NaiveDate::from_ymd_opt(utc_now.year(), utc_now.month(), 1).unwrap().format("%Y-%m-%d").to_string();
    let end_date = utc_now.format("%Y-%m-%d").to_string();

    let start_date = if start_date == end_date {
        NaiveDate::from_ymd_opt(utc_now.year(), utc_now.month() - 1, 1).unwrap().format("%Y-%m-%d").to_string()
    } else {
        start_date
    };
    info!("Start Date: {}", start_date);
    info!("End Date: {}", end_date);

    (start_date, end_date)
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

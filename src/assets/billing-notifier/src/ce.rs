use aws_config::BehaviorVersion;
use aws_sdk_costexplorer::{Client, Error, types::{DateInterval, Granularity, GroupDefinition, GroupDefinitionType}};
use rust_decimal::Decimal;
use rust_decimal::prelude::*;
use tracing::info;
use std::str::FromStr;

pub struct CostAndUsage{
		service: String,
		amount: f64,
}
impl CostAndUsage {
    pub fn amount(&self) -> f64 {
        self.amount
    }
    
    pub fn debug(&self) {
        info!("✅ service: {}, amount: {}", self.service, self.amount);
    }
}

pub async fn get_cost_and_usage_by_service(start_date: &String, end_date: &String) -> Result<Vec<CostAndUsage>, Error> {
    let config = aws_config::load_defaults(BehaviorVersion::latest()).await;
    let client = Client::new(&config);

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

    let mut costs_and_usages = Vec::new();

    if let Some(results_by_time) = response.results_by_time {
        results_by_time.iter().for_each(|result| {
            if let Some(groups) = &result.groups {
                groups.iter().for_each(|group| {
                    if let (Some(keys), Some(metrics)) = (&group.keys, &group.metrics) {
                        let amortized_cost = metrics.get("AmortizedCost").unwrap();

                        costs_and_usages.push(CostAndUsage {
                            service: keys.first().unwrap().clone(),
                            amount: convert_to_decimal_f64(amortized_cost.amount()),
                        });
                    }
                });
            }
        });
    }
    Ok(costs_and_usages)
}

fn convert_to_decimal_f64(amount: Option<&str>) -> f64 {
    amount.map_or(0.0, |value| {
        Decimal::from_str(value)
            .map_or(0.0, |decimal| decimal.round_dp(2).to_f64().unwrap_or(0.0))
    })
}

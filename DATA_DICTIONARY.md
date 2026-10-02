# Data Dictionary

## feeder_performance.csv

| Column | Description |
|---|---|
| month | Reporting month |
| feeder_id | Unique feeder identifier |
| feeder_name | Feeder name |
| division | Distribution division |
| zone | Operational zone |
| energy_input_kwh | Energy entering the feeder |
| energy_billed_kwh | Energy billed to consumers |
| technical_loss_kwh | Recorded technical loss |
| revenue_collected_inr | Revenue collected from the feeder |

## transformer_performance.csv

| Column | Description |
|---|---|
| month | Reporting month |
| transformer_id | Unique transformer identifier |
| feeder_id | Related feeder |
| division | Distribution division |
| capacity_kva | Transformer rated capacity |
| avg_load_pct | Average loading percentage |
| energy_supplied_kwh | Energy supplied through transformer |

## outages.csv

| Column | Description |
|---|---|
| outage_id | Unique outage identifier |
| outage_date | Date of outage |
| feeder_id | Related feeder |
| division | Distribution division |
| reason | Main outage reason |
| duration_minutes | Duration in minutes |
| customers_affected | Customers affected |
| outage_type | Planned or unplanned |

## consumer_billing.csv

| Column | Description |
|---|---|
| month | Billing month |
| consumer_id | Consumer identifier |
| feeder_id | Related feeder |
| division | Distribution division |
| segment | Consumer category |
| consumption_kwh | Monthly consumption |
| billed_amount_inr | Amount billed |
| amount_collected_inr | Amount collected |
| meter_route | Billing route |

## Derived metrics

- **Energy Loss %** = (Input - Billed) / Input
- **Collection Efficiency %** = Collected / Billed
- **Revenue Gap** = Billed - Collected
- **Average Outage Duration** = Average duration by selected period
- **Customer Impact** = Sum of affected customers

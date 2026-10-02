# Data Dictionary

The four CSVs are linked operational tables. The values are synthetic and are only meant to give the analysis a realistic structure.

## feeder_performance.csv

| Column | Description |
|---|---|
| month | Reporting month |
| feeder_id | Feeder identifier |
| feeder_name | Feeder name used in the sample |
| division | Distribution division |
| zone | Operational zone |
| energy_input_kwh | Energy entering the feeder |
| energy_billed_kwh | Energy billed to consumers |
| technical_loss_kwh | Difference between input and billed energy |
| revenue_collected_inr | Revenue collected against the feeder records |

## transformer_performance.csv

| Column | Description |
|---|---|
| month | Reporting month |
| transformer_id | Transformer identifier |
| feeder_id | Feeder supplied by the transformer |
| division | Distribution division |
| capacity_kva | Rated transformer capacity |
| avg_load_pct | Recorded average loading |
| energy_supplied_kwh | Energy supplied through the transformer |

## outages.csv

| Column | Description |
|---|---|
| outage_id | Outage identifier |
| outage_date | Date of outage |
| feeder_id | Feeder associated with the outage |
| division | Distribution division |
| reason | Recorded reason |
| duration_minutes | Outage duration |
| customers_affected | Customers affected by the outage |
| outage_type | Planned or unplanned |

## consumer_billing.csv

| Column | Description |
|---|---|
| month | Billing month |
| consumer_id | Consumer identifier |
| feeder_id | Feeder associated with the consumer |
| division | Distribution division |
| segment | Consumer category |
| consumption_kwh | Monthly consumption |
| billed_amount_inr | Amount billed |
| amount_collected_inr | Amount collected |
| meter_route | Meter/billing route |

## Derived metrics

- **Energy Loss %** = (Input - Billed) / Input
- **Collection Efficiency %** = Collected / Billed
- **Revenue Gap** = Billed - Collected
- **Average Outage Duration** = Average duration for the selected period
- **Customer Impact** = Sum of customers affected

# Power BI DAX Measures

Assume the main tables are named exactly like the CSV files.

## Energy Loss

```DAX
Total Input Energy =
SUM(feeder_performance[energy_input_kwh])
```

```DAX
Total Billed Energy =
SUM(feeder_performance[energy_billed_kwh])
```

```DAX
Energy Loss =
[Total Input Energy] - [Total Billed Energy]
```

```DAX
Energy Loss % =
DIVIDE([Energy Loss], [Total Input Energy])
```

## Revenue

```DAX
Billed Revenue =
SUM(consumer_billing[billed_amount_inr])
```

```DAX
Collected Revenue =
SUM(consumer_billing[amount_collected_inr])
```

```DAX
Collection Gap =
[Billed Revenue] - [Collected Revenue]
```

```DAX
Collection Efficiency % =
DIVIDE([Collected Revenue], [Billed Revenue])
```

## Reliability

```DAX
Outage Count =
COUNTROWS(outages)
```

```DAX
Customers Affected =
SUM(outages[customers_affected])
```

```DAX
Average Outage Duration =
AVERAGE(outages[duration_minutes])
```

## Asset loading

```DAX
Average Transformer Loading % =
AVERAGE(transformer_performance[avg_load_pct])
```

```DAX
High Load Transformers =
CALCULATE(
    DISTINCTCOUNT(transformer_performance[transformer_id]),
    transformer_performance[avg_load_pct] >= 85
)
```

Format percentage measures as percentages and currency measures as INR.

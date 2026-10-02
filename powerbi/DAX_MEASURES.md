# Power BI measures

These are the measures used for the utility report. Percentage measures should be formatted as percentages in Power BI.

## Energy

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

## Collections

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

## Outages

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

## Transformer loading

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

The 85% figure is a portfolio review threshold used to flag records for investigation. It is not being presented as an official utility operating limit.

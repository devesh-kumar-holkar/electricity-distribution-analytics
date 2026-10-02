# Electricity Distribution Analytics

I built this project around a simple utility-operations question:

**Where are distribution losses and reliability problems showing up, and what should an operations team look at first?**

The dataset is synthetic, but the tables are structured like a small distribution reporting system. The analysis uses feeder performance, transformer loading, outage records and consumer billing data.

There is no machine learning in this project.

## What I looked at

- feeder-wise energy loss
- loss movement over the year
- transformer loading
- outage frequency and duration
- customers affected by outages
- billed vs collected revenue
- feeders that repeatedly show high losses

The idea is to combine the operational pieces instead of treating loss, outages and billing as separate dashboards.

## Tools

- **Python / Pandas** — data checks and exploratory analysis
- **SQL** — KPI queries, trends, rankings and CTEs
- **Power BI** — dashboard design and KPI reporting
- **Excel** — optional checks and ad-hoc reporting

## Data

The sample represents 2025 and contains:

- 12 feeders
- 4 distribution divisions
- 24 transformers
- 240 outage records
- 1,200 consumer billing records

The data is synthetic and intended only for portfolio/learning use. It is not official utility data.

## Main questions

### Losses
Which feeders have the highest average loss? Is a high loss a one-month issue or something that keeps appearing?

### Reliability
Which outage reasons account for the most customer impact? Are some feeders seeing both higher losses and more outages?

### Assets
Which divisions have higher transformer loading, and which transformers repeatedly cross the 85% review threshold?

### Collections
Where is the gap between billed and collected revenue concentrated?

## Key calculations

**Energy Loss %**

`(energy input - energy billed) / energy input`

**Collection Efficiency %**

`amount collected / billed amount`

**Collection Gap**

`billed amount - collected amount`

**Transformer Loading %**

Taken from the recorded average loading field in the transformer table.

**Customer Impact**

Sum of customers affected by recorded outages.

## Dashboard

The Power BI plan is split into four pages:

1. **Overview** — loss, collection and reliability KPIs
2. **Feeder Loss** — feeder ranking and monthly loss movement
3. **Reliability & Assets** — outages, customer impact and transformer loading
4. **Revenue & Collection** — billed, collected and collection gap

The dashboard notes explain what each page is supposed to answer rather than prescribing a fixed set of charts.

## Repository

```text
data/
├── feeder_performance.csv
├── transformer_performance.csv
├── outages.csv
└── consumer_billing.csv

python/
└── eda_and_quality_checks.py

sql/
├── 00_schema.sql
├── 01_kpi_analysis.sql
└── 02_advanced_analysis.sql

powerbi/
├── DAX_MEASURES.md
└── DASHBOARD_BLUEPRINT.md

DATA_DICTIONARY.md
requirements.txt
README.md
```

## Workflow

**Check the source tables → calculate the base KPIs → investigate recurring problem areas → compare operational indicators → build the report.**

The project is intentionally closer to an analyst's reporting workflow than to a machine-learning project.

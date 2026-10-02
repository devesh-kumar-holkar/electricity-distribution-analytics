# Electricity Distribution Analytics

An end-to-end **Data Analyst portfolio project** built around a fictional electricity distribution utility.

The project focuses on operational reporting and business analysis using **Python, SQL and Power BI** — no machine learning.

## Business questions

- Which feeders have consistently high energy losses?
- How do distribution losses vary by division and month?
- Which transformers are operating close to their capacity?
- What are the main causes of outages and how many customers are affected?
- How efficiently is billed revenue being collected?
- Which areas deserve operational attention based on loss, reliability and asset-loading indicators?

## Tech stack

- **Python:** Pandas, NumPy, Matplotlib
- **SQL:** CTEs, aggregations, window functions, ranking and trend analysis
- **Power BI:** KPI cards, trend analysis, drill-downs and operational dashboards
- **Excel:** useful for ad-hoc validation and management reporting

## Dataset

The repository contains synthetic portfolio data representing 2025 operations:

- 12 feeders across 4 divisions
- 24 distribution transformers
- 240 outage records
- 1,200 consumer billing records
- Monthly feeder and transformer performance

The data is **synthetic and created for portfolio/learning purposes**. It is not official utility data.

## Key KPIs

**Energy Loss %**
`(Energy Input - Energy Billed) / Energy Input * 100`

**Collection Efficiency %**
`Amount Collected / Billed Amount * 100`

**Transformer Loading %**
Average operating load as a percentage of transformer capacity.

**Average Outage Duration**
Average outage duration in minutes.

**Customer Impact**
Total customers affected by recorded outages.

## Dashboard structure

### 1. Executive Overview
- Total energy input
- Energy billed
- Loss %
- Collection efficiency
- Customer impact
- Monthly loss trend

### 2. Feeder Loss Analytics
- Feeder ranking
- Division comparison
- Monthly loss trend
- Persistent high-loss feeders
- Input vs billed energy

### 3. Reliability & Asset Performance
- Outage count
- Average outage duration
- Customers affected
- Outage reason contribution
- Transformer loading

### 4. Revenue & Collection
- Billed amount
- Amount collected
- Collection efficiency
- Revenue collection gap
- Division and consumer-segment comparison

## Repository structure

```text
electricity-distribution-analytics/
├── data/
│   ├── feeder_performance.csv
│   ├── transformer_performance.csv
│   ├── outages.csv
│   └── consumer_billing.csv
├── python/
│   └── eda_and_quality_checks.py
├── sql/
│   ├── 00_schema.sql
│   ├── 01_kpi_analysis.sql
│   └── 02_advanced_analysis.sql
├── powerbi/
│   ├── DAX_MEASURES.md
│   └── DASHBOARD_BLUEPRINT.md
├── DATA_DICTIONARY.md
├── requirements.txt
└── README.md
```

## How to use

1. Load the CSV files into a SQL database or Power BI.
2. Run `python/eda_and_quality_checks.py` for basic validation and exploratory analysis.
3. Use the SQL scripts for KPI and deeper operational analysis.
4. Build the four Power BI pages using the dashboard blueprint and DAX measures.

## Analyst workflow demonstrated

**Raw operational data → data quality checks → KPI calculation → SQL analysis → dashboard-ready insights → management reporting**

> Note: This is an analytics project, not an ML model. The goal is to demonstrate practical business analysis, data preparation, SQL and dashboard thinking.

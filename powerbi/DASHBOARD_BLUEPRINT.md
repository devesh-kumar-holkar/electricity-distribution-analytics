# Power BI Dashboard Blueprint

## Page 1 — Executive Overview

**KPI cards**
- Total Input Energy
- Energy Loss %
- Collection Efficiency %
- Outage Count
- Customers Affected

**Visuals**
1. Monthly energy loss % line chart
2. Division-wise loss % column chart
3. Division-wise collection efficiency
4. Top 5 high-loss feeders table

**Slicers**
- Month
- Division
- Zone

---

## Page 2 — Feeder Loss Analytics

**Visuals**
1. Feeder loss ranking
2. Input vs billed energy by feeder
3. Monthly loss trend
4. High-loss months by feeder
5. Division and zone drill-down

**Suggested interaction**
Select a feeder to cross-filter the trend and supporting KPIs.

---

## Page 3 — Reliability & Asset Performance

**Visuals**
1. Outages by month
2. Outage reason contribution
3. Customers affected by reason
4. Transformer loading distribution
5. Feeder-wise outage table

**Operational flags**
- Transformer loading >= 85%
- High outage frequency
- Long average outage duration

---

## Page 4 — Revenue & Collection

**Visuals**
1. Monthly billed vs collected revenue
2. Collection efficiency by division
3. Collection gap by consumer segment
4. Consumer segment contribution
5. Meter route performance

**Business questions**
- Where is the collection gap concentrated?
- Which consumer segments have lower collection efficiency?
- Is collection efficiency improving month over month?

## Design notes

Keep the dashboard management-friendly:
- Start with KPI cards.
- Use consistent month and division filters.
- Avoid excessive charts.
- Show the underlying table for operational follow-up.
- Add tooltips with feeder, division and KPI context.

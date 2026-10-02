# Power BI dashboard notes

The report is arranged in the same order I would review the data: start with the overall position, then move to the feeders and assets causing the operational questions.

## 1. Overview

**Question:** How are losses, reliability and collections moving overall?

Start with:

- Total input energy
- Total billed energy
- Energy loss %
- Collection efficiency %
- Outage count
- Customers affected

Useful views:

- monthly loss %
- loss % by division
- billed vs collected revenue
- top feeders by average loss

Filters: month, division and zone.

## 2. Feeder loss

**Question:** Which feeders need a closer look?

Use:

- feeder loss ranking
- input vs billed energy
- monthly loss trend
- number of months above the 12% review line

A feeder should not be flagged because of one unusual month. The recurring-loss view is there to separate a persistent pattern from a one-off spike.

## 3. Reliability and assets

**Question:** Where are outages and high loading concentrated?

Use:

- outage count
- average outage duration
- customers affected
- outage reason
- transformer loading

Show the feeder table alongside the charts so an operational user can move from the summary to the actual feeder.

For this portfolio, 85% transformer loading is treated as a review threshold, not as a utility standard.

## 4. Revenue and collection

**Question:** Where is billed revenue not being collected?

Use:

- billed vs collected trend
- collection efficiency by division
- collection gap by consumer segment
- collection gap by meter route

The dashboard should make it possible to move from a division-level gap to the consumer segment or route behind it.

## Layout

Keep the first page simple. Use the other pages for investigation.

Avoid filling the report with gauges. A trend, a ranking and a supporting table usually give more context for these questions.

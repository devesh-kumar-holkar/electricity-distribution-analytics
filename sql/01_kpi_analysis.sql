-- Base questions for the distribution report.

-- 1. How is loss moving across divisions?
SELECT
    month,
    division,
    SUM(energy_input_kwh) AS input_kwh,
    SUM(energy_billed_kwh) AS billed_kwh,
    SUM(energy_input_kwh - energy_billed_kwh) AS loss_kwh,
    ROUND(
        100.0 * SUM(energy_input_kwh - energy_billed_kwh)
        / NULLIF(SUM(energy_input_kwh), 0), 2
    ) AS loss_pct
FROM feeder_performance
GROUP BY month, division
ORDER BY month, division;


-- 2. Which feeders have the highest average loss?
SELECT
    feeder_id,
    feeder_name,
    division,
    ROUND(
        AVG(
            100.0 * (energy_input_kwh - energy_billed_kwh)
            / NULLIF(energy_input_kwh, 0)
        ), 2
    ) AS avg_loss_pct
FROM feeder_performance
GROUP BY feeder_id, feeder_name, division
ORDER BY avg_loss_pct DESC;


-- 3. What does transformer loading look like by division?
SELECT
    division,
    ROUND(AVG(avg_load_pct), 2) AS avg_loading_pct,
    ROUND(MAX(avg_load_pct), 2) AS peak_recorded_loading_pct,
    COUNT(DISTINCT transformer_id) AS transformers
FROM transformer_performance
GROUP BY division
ORDER BY avg_loading_pct DESC;


-- 4. Which divisions have the highest outage impact?
SELECT
    division,
    COUNT(*) AS outage_count,
    ROUND(AVG(duration_minutes), 2) AS avg_duration_min,
    SUM(customers_affected) AS customers_affected
FROM outages
GROUP BY division
ORDER BY customers_affected DESC;


-- 5. Where is the collection gap?
SELECT
    month,
    division,
    SUM(billed_amount_inr) AS billed_inr,
    SUM(amount_collected_inr) AS collected_inr,
    SUM(billed_amount_inr - amount_collected_inr) AS collection_gap_inr,
    ROUND(
        100.0 * SUM(amount_collected_inr)
        / NULLIF(SUM(billed_amount_inr), 0), 2
    ) AS collection_efficiency_pct
FROM consumer_billing
GROUP BY month, division
ORDER BY month, division;

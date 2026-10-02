-- A few follow-up questions after the base KPI review.

-- 1. Did the overall loss rate change from the previous month?
WITH monthly AS (
    SELECT
        month,
        SUM(energy_input_kwh) AS input_kwh,
        SUM(energy_billed_kwh) AS billed_kwh
    FROM feeder_performance
    GROUP BY month
),
trend AS (
    SELECT
        month,
        100.0 * (input_kwh - billed_kwh)
            / NULLIF(input_kwh, 0) AS loss_pct,
        LAG(
            100.0 * (input_kwh - billed_kwh)
            / NULLIF(input_kwh, 0)
        ) OVER (ORDER BY month) AS previous_loss_pct
    FROM monthly
)
SELECT
    month,
    ROUND(loss_pct, 2) AS loss_pct,
    ROUND(previous_loss_pct, 2) AS previous_loss_pct,
    ROUND(loss_pct - previous_loss_pct, 2) AS change_vs_previous_month
FROM trend
ORDER BY month;


-- 2. Which feeders repeatedly cross the 12% loss review line?
WITH feeder_monthly AS (
    SELECT
        feeder_id,
        feeder_name,
        division,
        month,
        100.0 * (energy_input_kwh - energy_billed_kwh)
            / NULLIF(energy_input_kwh, 0) AS loss_pct
    FROM feeder_performance
)
SELECT
    feeder_id,
    feeder_name,
    division,
    SUM(CASE WHEN loss_pct >= 12 THEN 1 ELSE 0 END) AS high_loss_months,
    ROUND(AVG(loss_pct), 2) AS avg_loss_pct
FROM feeder_monthly
GROUP BY feeder_id, feeder_name, division
HAVING SUM(CASE WHEN loss_pct >= 12 THEN 1 ELSE 0 END) >= 6
ORDER BY high_loss_months DESC, avg_loss_pct DESC;


-- 3. Which outage reasons account for most customer impact?
WITH reason_summary AS (
    SELECT
        reason,
        COUNT(*) AS outage_count,
        SUM(duration_minutes) AS total_duration_min,
        SUM(customers_affected) AS customers_affected
    FROM outages
    GROUP BY reason
)
SELECT
    reason,
    outage_count,
    total_duration_min,
    customers_affected,
    ROUND(
        100.0 * customers_affected
        / NULLIF(SUM(customers_affected) OVER (), 0), 2
    ) AS customer_impact_share_pct
FROM reason_summary
ORDER BY customers_affected DESC;


-- 4. Which feeders have both loss and outage activity?
WITH loss AS (
    SELECT
        feeder_id,
        ROUND(
            AVG(
                100.0 * (energy_input_kwh - energy_billed_kwh)
                / NULLIF(energy_input_kwh, 0)
            ), 2
        ) AS avg_loss_pct
    FROM feeder_performance
    GROUP BY feeder_id
),
reliability AS (
    SELECT
        feeder_id,
        COUNT(*) AS outage_count,
        ROUND(AVG(duration_minutes), 2) AS avg_outage_duration_min,
        SUM(customers_affected) AS customers_affected
    FROM outages
    GROUP BY feeder_id
)
SELECT
    l.feeder_id,
    l.avg_loss_pct,
    COALESCE(r.outage_count, 0) AS outage_count,
    COALESCE(r.avg_outage_duration_min, 0) AS avg_outage_duration_min,
    COALESCE(r.customers_affected, 0) AS customers_affected
FROM loss l
LEFT JOIN reliability r
    ON l.feeder_id = r.feeder_id
ORDER BY l.avg_loss_pct DESC, customers_affected DESC;

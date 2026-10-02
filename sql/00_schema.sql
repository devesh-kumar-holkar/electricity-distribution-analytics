-- PostgreSQL-style schema for Electricity Distribution Analytics

CREATE TABLE feeder_performance (
    month DATE,
    feeder_id VARCHAR(20),
    feeder_name VARCHAR(100),
    division VARCHAR(50),
    zone VARCHAR(50),
    energy_input_kwh NUMERIC(14,2),
    energy_billed_kwh NUMERIC(14,2),
    technical_loss_kwh NUMERIC(14,2),
    revenue_collected_inr NUMERIC(14,2)
);

CREATE TABLE transformer_performance (
    month DATE,
    transformer_id VARCHAR(20),
    feeder_id VARCHAR(20),
    division VARCHAR(50),
    capacity_kva NUMERIC(10,2),
    avg_load_pct NUMERIC(6,2),
    energy_supplied_kwh NUMERIC(14,2)
);

CREATE TABLE outages (
    outage_id VARCHAR(20),
    outage_date DATE,
    feeder_id VARCHAR(20),
    division VARCHAR(50),
    reason VARCHAR(50),
    duration_minutes INTEGER,
    customers_affected INTEGER,
    outage_type VARCHAR(20)
);

CREATE TABLE consumer_billing (
    month DATE,
    consumer_id VARCHAR(20),
    feeder_id VARCHAR(20),
    division VARCHAR(50),
    segment VARCHAR(30),
    consumption_kwh NUMERIC(12,2),
    billed_amount_inr NUMERIC(14,2),
    amount_collected_inr NUMERIC(14,2),
    meter_route VARCHAR(30)
);

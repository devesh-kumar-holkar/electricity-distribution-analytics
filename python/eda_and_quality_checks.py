"""
Quick checks for the electricity distribution dataset.

Run from the repository root:
    python python/eda_and_quality_checks.py
"""

from pathlib import Path
import pandas as pd

DATA = Path(__file__).resolve().parents[1] / "data"


def load_tables():
    feeder = pd.read_csv(DATA / "feeder_performance.csv", parse_dates=["month"])
    transformer = pd.read_csv(
        DATA / "transformer_performance.csv", parse_dates=["month"]
    )
    outages = pd.read_csv(DATA / "outages.csv", parse_dates=["outage_date"])
    billing = pd.read_csv(
        DATA / "consumer_billing.csv", parse_dates=["month"]
    )
    return feeder, transformer, outages, billing


def check_table(df, name):
    print(f"\n{name}")
    print("-" * len(name))
    print(f"Rows: {len(df):,}")
    print(f"Columns: {len(df.columns)}")
    print(f"Duplicate rows: {df.duplicated().sum():,}")

    missing = df.isna().sum()
    missing = missing[missing.gt(0)]

    if missing.empty:
        print("Missing values: none")
    else:
        print("Missing values:")
        print(missing)


def main():
    feeder, transformer, outages, billing = load_tables()

    for df, name in [
        (feeder, "Feeder performance"),
        (transformer, "Transformer performance"),
        (outages, "Outages"),
        (billing, "Consumer billing"),
    ]:
        check_table(df, name)

    # Feeder loss
    feeder["loss_pct"] = (
        (feeder["energy_input_kwh"] - feeder["energy_billed_kwh"])
        / feeder["energy_input_kwh"].replace(0, pd.NA)
        * 100
    )

    print("\nHighest average feeder losses")
    print("-----------------------------")
    feeder_summary = (
        feeder.groupby(["feeder_id", "feeder_name", "division"], as_index=False)
        .agg(
            avg_loss_pct=("loss_pct", "mean"),
            avg_input_kwh=("energy_input_kwh", "mean"),
        )
        .sort_values("avg_loss_pct", ascending=False)
        .head(10)
    )
    print(feeder_summary.to_string(index=False, float_format="%.2f"))

    print("\nTransformer loading by division")
    print("--------------------------------")
    loading = (
        transformer.groupby("division")["avg_load_pct"]
        .agg(avg_loading_pct="mean", peak_loading_pct="max")
        .round(2)
    )
    print(loading)

    print("\nOutages by reason")
    print("-----------------")
    outage_summary = (
        outages.groupby("reason")
        .agg(
            outage_count=("outage_id", "count"),
            customers_affected=("customers_affected", "sum"),
            avg_duration_min=("duration_minutes", "mean"),
        )
        .sort_values("customers_affected", ascending=False)
        .round(2)
    )
    print(outage_summary)

    print("\nCollection efficiency by division")
    print("----------------------------------")
    collection = billing.groupby("division").agg(
        billed_inr=("billed_amount_inr", "sum"),
        collected_inr=("amount_collected_inr", "sum"),
    )
    collection["collection_efficiency_pct"] = (
        collection["collected_inr"] / collection["billed_inr"].replace(0, pd.NA)
    ) * 100
    print(collection.round(2))


if __name__ == "__main__":
    main()

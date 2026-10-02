"""
Electricity Distribution Analytics
Basic data-quality checks and exploratory analysis.
"""

from pathlib import Path
import pandas as pd

DATA = Path(__file__).resolve().parents[1] / "data"


def load_data():
    feeder = pd.read_csv(DATA / "feeder_performance.csv", parse_dates=["month"])
    transformer = pd.read_csv(DATA / "transformer_performance.csv", parse_dates=["month"])
    outages = pd.read_csv(DATA / "outages.csv", parse_dates=["outage_date"])
    billing = pd.read_csv(DATA / "consumer_billing.csv", parse_dates=["month"])
    return feeder, transformer, outages, billing


def quality_report(df, name):
    print(f"\n--- {name} ---")
    print("Rows:", len(df))
    print("Columns:", len(df.columns))
    print("Duplicate rows:", df.duplicated().sum())
    print("Missing values:")
    print(df.isna().sum().loc[lambda s: s.gt(0)])


def main():
    feeder, transformer, outages, billing = load_data()

    quality_report(feeder, "Feeder performance")
    quality_report(transformer, "Transformer performance")
    quality_report(outages, "Outages")
    quality_report(billing, "Consumer billing")

    feeder["loss_pct"] = (
        (feeder["energy_input_kwh"] - feeder["energy_billed_kwh"])
        / feeder["energy_input_kwh"] * 100
    )

    transformer["loading_flag"] = transformer["avg_load_pct"].ge(85)

    billing["collection_efficiency_pct"] = (
        billing["amount_collected_inr"] / billing["billed_amount_inr"] * 100
    )

    print("\nTop 10 feeders by average energy loss:")
    feeder_summary = (
        feeder.groupby(["feeder_id", "feeder_name", "division"], as_index=False)
        .agg(
            avg_loss_pct=("loss_pct", "mean"),
            avg_input_kwh=("energy_input_kwh", "mean"),
        )
        .sort_values("avg_loss_pct", ascending=False)
        .head(10)
    )
    print(feeder_summary.to_string(index=False))

    print("\nTransformer loading summary:")
    print(
        transformer.groupby("division")["avg_load_pct"]
        .agg(["mean", "max"])
        .round(2)
    )

    print("\nOutage summary by reason:")
    print(
        outages.groupby("reason")
        .agg(
            outages=("outage_id", "count"),
            customers_affected=("customers_affected", "sum"),
            avg_duration_min=("duration_minutes", "mean"),
        )
        .sort_values("customers_affected", ascending=False)
        .round(2)
    )

    print("\nCollection efficiency by division:")
    collection = (
        billing.groupby("division")
        .agg(
            billed_inr=("billed_amount_inr", "sum"),
            collected_inr=("amount_collected_inr", "sum"),
        )
    )
    collection["collection_efficiency_pct"] = (
        collection["collected_inr"] / collection["billed_inr"] * 100
    )
    print(collection.round(2))


if __name__ == "__main__":
    main()

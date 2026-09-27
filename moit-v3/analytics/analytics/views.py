import json
import pandas as pd

from django.shortcuts import render
from .services import get_advertisement_analytics


def calc_change(current, previous):
    """
    이전 기간 대비 증감률
    """
    if previous == 0:
        if current == 0:
            return 0
        return 100

    return round(((current - previous) / previous) * 100, 1)


def dashboard(request):

    data = get_advertisement_analytics()
    df = pd.DataFrame(data)

    context = {
        "total_impressions": 0,
        "total_clicks": 0,
        "avg_ctr": 0,
        "ad_count": 0,

        "impression_change": 0,
        "click_change": 0,
        "ctr_change": 0,
        "ad_count_change": 0,

        "daily_labels": json.dumps([]),
        "daily_impressions": json.dumps([]),
        "daily_clicks": json.dumps([]),

        "ad_labels": json.dumps([]),
        "ad_impressions": json.dumps([]),
        "ad_clicks": json.dumps([]),

        "grade_labels": json.dumps([]),
        "grade_values": json.dumps([]),

        "position_labels": json.dumps([]),
        "position_impressions": json.dumps([]),

        "ad_table": [],
    }

    if df.empty:
        return render(
            request,
            "analytics/dashboard.html",
            context
        )

    # =========================
    # 데이터 타입 정리
    # =========================

    df["statDate"] = pd.to_datetime(
        df["statDate"]
    )

    df["impressions"] = pd.to_numeric(
        df["impressions"],
        errors="coerce"
    ).fillna(0)

    df["clicks"] = pd.to_numeric(
        df["clicks"],
        errors="coerce"
    ).fillna(0)

    df["ctr"] = (
        df["clicks"]
        / df["impressions"].replace(0, 1)
    ) * 100

    df = df.sort_values("statDate")

    # =========================
    # 기간 계산
    # =========================

    max_date = df["statDate"].max()

    current_start = max_date - pd.Timedelta(days=14)
    previous_start = max_date - pd.Timedelta(days=29)
    previous_end = max_date - pd.Timedelta(days=15)

    current_df = df[
        df["statDate"] >= current_start
    ]

    previous_df = df[
        (df["statDate"] >= previous_start)
        & (df["statDate"] <= previous_end)
    ]

    # =========================
    # 현재 KPI
    # =========================

    total_impressions = int(
        current_df["impressions"].sum()
    )

    total_clicks = int(
        current_df["clicks"].sum()
    )

    avg_ctr = round(
        current_df["ctr"].mean(),
        2
    )

    ad_count = int(
        current_df["advertisementId"].nunique()
    )

    # =========================
    # 이전 KPI
    # =========================

    previous_impressions = int(
        previous_df["impressions"].sum()
    )

    previous_clicks = int(
        previous_df["clicks"].sum()
    )

    previous_ctr = round(
        previous_df["ctr"].mean(),
        2
    ) if not previous_df.empty else 0

    previous_ad_count = int(
        previous_df["advertisementId"].nunique()
    )

    # =========================
    # 증감률
    # =========================

    context["total_impressions"] = total_impressions
    context["total_clicks"] = total_clicks
    context["avg_ctr"] = avg_ctr
    context["ad_count"] = ad_count

    context["impression_change"] = calc_change(
        total_impressions,
        previous_impressions
    )

    context["click_change"] = calc_change(
        total_clicks,
        previous_clicks
    )

    context["ctr_change"] = calc_change(
        avg_ctr,
        previous_ctr
    )

    context["ad_count_change"] = calc_change(
        ad_count,
        previous_ad_count
    )

    # =========================
    # 일별 데이터
    # =========================

    daily = (
        current_df
        .groupby("statDate")[["impressions", "clicks"]]
        .sum()
        .reset_index()
        .sort_values("statDate")
    )

    context["daily_labels"] = json.dumps(
        daily["statDate"]
        .dt.strftime("%m/%d")
        .tolist()
    )

    context["daily_impressions"] = json.dumps(
        daily["impressions"]
        .astype(int)
        .tolist()
    )

    context["daily_clicks"] = json.dumps(
        daily["clicks"]
        .astype(int)
        .tolist()
    )

    # =========================
    # 광고별 데이터
    # =========================

    ads = (
        current_df
        .groupby(
            ["advertisementId", "title"],
            as_index=False
        )[["impressions", "clicks"]]
        .sum()
        .sort_values(
            "impressions",
            ascending=True
        )
    )

    ads["ctr"] = (
        ads["clicks"]
        / ads["impressions"].replace(0, 1)
    ) * 100

    context["ad_labels"] = json.dumps(
        ads["title"].tolist(),
        ensure_ascii=False
    )

    context["ad_impressions"] = json.dumps(
        ads["impressions"]
        .astype(int)
        .tolist()
    )

    context["ad_clicks"] = json.dumps(
        ads["clicks"]
        .astype(int)
        .tolist()
    )

    # =========================
    # 상세 테이블
    # =========================

    ad_table = []

    for _, row in ads.iterrows():

        ad_id = int(
            row["advertisementId"]
        )

        ad_info = (
            current_df[
                current_df["advertisementId"] == ad_id
            ]
            .iloc[0]
        )

        ad_table.append({
            "title": row["title"],
            "grade": ad_info["grade"],
            "position": ad_info["position"],
            "impressions": int(row["impressions"]),
            "clicks": int(row["clicks"]),
            "ctr": round(row["ctr"], 2),
        })

    context["ad_table"] = ad_table

    # =========================
    # 등급별
    # =========================

    grade = (
        current_df
        .groupby("grade")["impressions"]
        .sum()
        .reset_index()
    )

    context["grade_labels"] = json.dumps(
        grade["grade"].tolist()
    )

    context["grade_values"] = json.dumps(
        grade["impressions"]
        .astype(int)
        .tolist()
    )

    # =========================
    # 위치별
    # =========================

    position = (
        current_df
        .groupby("position")["impressions"]
        .sum()
        .reset_index()
        .sort_values(
            "impressions",
            ascending=True
        )
    )

    context["position_labels"] = json.dumps(
        position["position"].tolist()
    )

    context["position_impressions"] = json.dumps(
        position["impressions"]
        .astype(int)
        .tolist()
    )

    return render(
        request,
        "analytics/dashboard.html",
        context
    )
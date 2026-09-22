import json

import pandas as pd
from django.shortcuts import render

from .services import get_advertisement_analytics


def dashboard(request):
    data = get_advertisement_analytics()
    df = pd.DataFrame(data)

    context = {
        "total_impressions": 0,
        "total_clicks": 0,
        "avg_ctr": 0,
        "ad_count": 0,

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

    if not df.empty:

        # -------------------------
        # 기본 데이터 정리
        # -------------------------

        df["impressions"] = pd.to_numeric(
            df["impressions"],
            errors="coerce"
        ).fillna(0)

        df["clicks"] = pd.to_numeric(
            df["clicks"],
            errors="coerce"
        ).fillna(0)

        # -------------------------
        # CTR 계산
        # -------------------------

        df["ctr"] = (
            df["clicks"]
            / df["impressions"].replace(0, 1)
        ) * 100

        # -------------------------
        # KPI
        # -------------------------

        context["total_impressions"] = int(
            df["impressions"].sum()
        )

        context["total_clicks"] = int(
            df["clicks"].sum()
        )

        context["avg_ctr"] = round(
            df["ctr"].mean(),
            2
        )

        context["ad_count"] = int(
            df["advertisementId"].nunique()
        )

        # -------------------------
        # 일별 통계
        # -------------------------

        daily = (
            df.groupby("statDate")[
                ["impressions", "clicks"]
            ]
            .sum()
            .reset_index()
            .sort_values("statDate")
        )

        context["daily_labels"] = json.dumps(
            daily["statDate"]
            .astype(str)
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

        # -------------------------
        # 광고별 통계
        # -------------------------

        ads = (
            df.groupby(
                ["advertisementId", "title"],
                as_index=False
            )[["impressions", "clicks"]]
            .sum()
            .sort_values(
                "impressions",
                ascending=False
            )
        )

        ads["ctr"] = (
            ads["clicks"]
            / ads["impressions"].replace(0, 1)
        ) * 100

        context["ad_labels"] = json.dumps(
            ads["title"].tolist()
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

        # -------------------------
        # 상세 테이블
        # -------------------------

        ad_table = []

        for _, row in ads.iterrows():

            ad_id = int(row["advertisementId"])

            # 같은 광고의 등급 / 위치
            ad_info = df[
                df["advertisementId"] == ad_id
            ].iloc[0]

            ad_table.append({
                "title": row["title"],
                "grade": ad_info["grade"],
                "position": ad_info["position"],
                "impressions": int(
                    row["impressions"]
                ),
                "clicks": int(
                    row["clicks"]
                ),
                "ctr": round(
                    row["ctr"],
                    2
                ),
            })

        context["ad_table"] = ad_table

        # -------------------------
        # 등급별 통계
        # -------------------------

        grade = (
            df.groupby("grade")["impressions"]
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

        # -------------------------
        # 위치별 통계
        # -------------------------

        position = (
            df.groupby("position")["impressions"]
            .sum()
            .reset_index()
            .sort_values(
                "impressions",
                ascending=False
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
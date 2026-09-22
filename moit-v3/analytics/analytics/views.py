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
    }

    if not df.empty:

        df["ctr"] = (
            df["clicks"]
            / df["impressions"].replace(0, 1)
        ) * 100

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

    return render(
        request,
        "analytics/dashboard.html",
        context
    )
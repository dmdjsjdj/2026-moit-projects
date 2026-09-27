import requests


SPRING_API_URL = (
    "http://127.0.0.1:8080"
    "/api/admin/advertisement/analytics"
)


def get_advertisement_analytics():
    response = requests.get(
        SPRING_API_URL,
        timeout=10
    )

    response.raise_for_status()

    return response.json()
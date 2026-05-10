from django.urls import path

from .views import (
    RecommendationView,
    PredictionView,
    AIHistoryView
)

urlpatterns = [

    path(
        'recommendations/',
        RecommendationView.as_view(),
        name='ai-recommendations'
    ),

    path(
        'predictions/',
        PredictionView.as_view(),
        name='ai-predictions'
    ),

    path(
        'history/',
        AIHistoryView.as_view(),
        name='ai-history'
    ),
]

from django.urls import path

from .views import (
    AIRecommendationView,
    AIChatbotView,
    LearningPathView,
)

app_name = "ai_engine"

urlpatterns = [

    path(
        "recommendations/",
        AIRecommendationView.as_view(),
        name="recommendations",
    ),

    path(
        "chatbot/",
        AIChatbotView.as_view(),
        name="chatbot",
    ),

    path(
        "learning-path/",
        LearningPathView.as_view(),
        name="learning-path",
    ),
]

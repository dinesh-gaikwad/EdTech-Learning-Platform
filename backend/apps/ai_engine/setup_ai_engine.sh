#!/bin/bash

set -e

BASE="/workspaces/EdTech-Learning-Platform/backend/apps/ai_engine"

mkdir -p $BASE/migrations

touch $BASE/migrations/__init__.py

# __init__.py
cat > $BASE/__init__.py << 'PY'
default_app_config = 'ai_engine.apps.AIEngineConfig'
PY

# apps.py
cat > $BASE/apps.py << 'PY'
from django.apps import AppConfig


class AIEngineConfig(AppConfig):
    default_auto_field = 'django.db.models.BigAutoField'
    name = 'ai_engine'
    verbose_name = 'AI Recommendation Engine'
PY

# admin.py
cat > $BASE/admin.py << 'PY'
from django.contrib import admin

from .models import (
    AIRecommendation,
    LearningPrediction,
    StudentBehavior
)

admin.site.register(AIRecommendation)
admin.site.register(LearningPrediction)
admin.site.register(StudentBehavior)
PY

# models.py
cat > $BASE/models.py << 'PY'
from django.db import models
from django.contrib.auth import get_user_model

User = get_user_model()


class AIRecommendation(models.Model):

    user = models.ForeignKey(
        User,
        on_delete=models.CASCADE
    )

    recommended_course = models.CharField(
        max_length=255
    )

    recommendation_score = models.FloatField(
        default=0
    )

    generated_at = models.DateTimeField(
        auto_now_add=True
    )

    def __str__(self):
        return self.recommended_course


class LearningPrediction(models.Model):

    user = models.ForeignKey(
        User,
        on_delete=models.CASCADE
    )

    predicted_completion_rate = models.FloatField(
        default=0
    )

    predicted_score = models.FloatField(
        default=0
    )

    generated_at = models.DateTimeField(
        auto_now_add=True
    )

    def __str__(self):
        return self.user.username


class StudentBehavior(models.Model):

    user = models.ForeignKey(
        User,
        on_delete=models.CASCADE
    )

    total_watch_time = models.IntegerField(
        default=0
    )

    average_session_time = models.FloatField(
        default=0
    )

    login_frequency = models.IntegerField(
        default=0
    )

    preferred_category = models.CharField(
        max_length=255,
        blank=True
    )

    updated_at = models.DateTimeField(
        auto_now=True
    )

    def __str__(self):
        return self.user.username
PY

# serializers.py
cat > $BASE/serializers.py << 'PY'
from rest_framework import serializers

from .models import (
    AIRecommendation,
    LearningPrediction,
    StudentBehavior
)


class AIRecommendationSerializer(
    serializers.ModelSerializer
):

    class Meta:
        model = AIRecommendation
        fields = '__all__'


class LearningPredictionSerializer(
    serializers.ModelSerializer
):

    class Meta:
        model = LearningPrediction
        fields = '__all__'


class StudentBehaviorSerializer(
    serializers.ModelSerializer
):

    class Meta:
        model = StudentBehavior
        fields = '__all__'
PY

# recommendation_engine.py
cat > $BASE/recommendation_engine.py << 'PY'
import random


class RecommendationEngine:

    @staticmethod
    def generate_recommendations(user):

        sample_courses = [

            'Advanced Python',
            'Django Mastery',
            'React.js Bootcamp',
            'Machine Learning',
            'Docker & Kubernetes'
        ]

        recommendations = []

        for course in sample_courses:

            recommendations.append({

                'course': course,

                'score': round(
                    random.uniform(0.5, 0.99),
                    2
                )
            })

        return recommendations
PY

# prediction_engine.py
cat > $BASE/prediction_engine.py << 'PY'
import random


class PredictionEngine:

    @staticmethod
    def predict_completion():

        return round(
            random.uniform(60, 100),
            2
        )

    @staticmethod
    def predict_exam_score():

        return round(
            random.uniform(70, 99),
            2
        )
PY

# services.py
cat > $BASE/services.py << 'PY'
from .models import (
    AIRecommendation,
    LearningPrediction
)

from .recommendation_engine import (
    RecommendationEngine
)

from .prediction_engine import (
    PredictionEngine
)


class AIService:

    @staticmethod
    def generate_user_recommendations(
        user
    ):

        recommendations = (
            RecommendationEngine.generate_recommendations(
                user
            )
        )

        saved = []

        for item in recommendations:

            rec = AIRecommendation.objects.create(
                user=user,
                recommended_course=item['course'],
                recommendation_score=item['score']
            )

            saved.append(rec)

        return saved

    @staticmethod
    def generate_prediction(user):

        completion_rate = (
            PredictionEngine.predict_completion()
        )

        predicted_score = (
            PredictionEngine.predict_exam_score()
        )

        prediction = LearningPrediction.objects.create(
            user=user,
            predicted_completion_rate=completion_rate,
            predicted_score=predicted_score
        )

        return prediction
PY

# views.py
cat > $BASE/views.py << 'PY'
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework.permissions import (
    IsAuthenticated
)

from .models import (
    AIRecommendation,
    LearningPrediction
)

from .serializers import (
    AIRecommendationSerializer,
    LearningPredictionSerializer
)

from .services import AIService


class RecommendationView(APIView):

    permission_classes = [IsAuthenticated]

    def get(self, request):

        recommendations = (
            AIService.generate_user_recommendations(
                request.user
            )
        )

        serializer = AIRecommendationSerializer(
            recommendations,
            many=True
        )

        return Response(serializer.data)


class PredictionView(APIView):

    permission_classes = [IsAuthenticated]

    def get(self, request):

        prediction = AIService.generate_prediction(
            request.user
        )

        serializer = LearningPredictionSerializer(
            prediction
        )

        return Response(serializer.data)


class AIHistoryView(APIView):

    permission_classes = [IsAuthenticated]

    def get(self, request):

        recommendations = AIRecommendation.objects.filter(
            user=request.user
        )

        serializer = AIRecommendationSerializer(
            recommendations,
            many=True
        )

        return Response(serializer.data)
PY

# urls.py
cat > $BASE/urls.py << 'PY'
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
PY

# tests.py
cat > $BASE/tests.py << 'PY'
from django.test import TestCase
from django.contrib.auth import get_user_model

from .models import (
    AIRecommendation
)

User = get_user_model()


class AIEngineTestCase(TestCase):

    def setUp(self):

        self.user = User.objects.create_user(
            username='dinesh',
            password='StrongPassword123'
        )

        self.recommendation = (
            AIRecommendation.objects.create(
                user=self.user,
                recommended_course='Advanced Python',
                recommendation_score=0.95
            )
        )

    def test_recommendation_created(self):

        self.assertEqual(
            self.recommendation.recommended_course,
            'Advanced Python'
        )

    def test_recommendation_score(self):

        self.assertEqual(
            self.recommendation.recommendation_score,
            0.95
        )
PY

chmod +x $BASE/setup_ai_engine.sh

echo "✅ AI Engine module generated successfully"

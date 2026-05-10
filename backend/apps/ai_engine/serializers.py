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

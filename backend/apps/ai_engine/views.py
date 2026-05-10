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

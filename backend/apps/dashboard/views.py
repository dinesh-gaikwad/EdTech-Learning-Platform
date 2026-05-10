from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework.permissions import (
    IsAuthenticated
)

from .models import (
    DashboardMetric,
    StudentAnalytics,
    InstructorAnalytics
)

from .serializers import (
    DashboardMetricSerializer,
    StudentAnalyticsSerializer,
    InstructorAnalyticsSerializer
)


class DashboardMetricsView(APIView):

    permission_classes = [IsAuthenticated]

    def get(self, request):

        metrics = DashboardMetric.objects.all()

        serializer = DashboardMetricSerializer(
            metrics,
            many=True
        )

        return Response(serializer.data)


class StudentAnalyticsView(APIView):

    permission_classes = [IsAuthenticated]

    def get(self, request):

        analytics = StudentAnalytics.objects.filter(
            student=request.user
        )

        serializer = StudentAnalyticsSerializer(
            analytics,
            many=True
        )

        return Response(serializer.data)


class InstructorAnalyticsView(APIView):

    permission_classes = [IsAuthenticated]

    def get(self, request):

        analytics = InstructorAnalytics.objects.filter(
            instructor=request.user
        )

        serializer = InstructorAnalyticsSerializer(
            analytics,
            many=True
        )

        return Response(serializer.data)

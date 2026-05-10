from rest_framework import serializers

from .models import (
    DashboardMetric,
    StudentAnalytics,
    InstructorAnalytics
)


class DashboardMetricSerializer(
    serializers.ModelSerializer
):

    class Meta:
        model = DashboardMetric
        fields = '__all__'


class StudentAnalyticsSerializer(
    serializers.ModelSerializer
):

    class Meta:
        model = StudentAnalytics
        fields = '__all__'


class InstructorAnalyticsSerializer(
    serializers.ModelSerializer
):

    class Meta:
        model = InstructorAnalytics
        fields = '__all__'

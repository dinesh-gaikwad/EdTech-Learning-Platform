#!/bin/bash

set -e

BASE="/workspaces/EdTech-Learning-Platform/backend/apps/dashboard"

mkdir -p $BASE/migrations

touch $BASE/migrations/__init__.py

# __init__.py
cat > $BASE/__init__.py << 'PY'
default_app_config = 'dashboard.apps.DashboardConfig'
PY

# apps.py
cat > $BASE/apps.py << 'PY'
from django.apps import AppConfig


class DashboardConfig(AppConfig):
    default_auto_field = 'django.db.models.BigAutoField'
    name = 'dashboard'
    verbose_name = 'Analytics Dashboard'
PY

# admin.py
cat > $BASE/admin.py << 'PY'
from django.contrib import admin

from .models import (
    DashboardMetric,
    StudentAnalytics,
    InstructorAnalytics
)

admin.site.register(DashboardMetric)
admin.site.register(StudentAnalytics)
admin.site.register(InstructorAnalytics)
PY

# models.py
cat > $BASE/models.py << 'PY'
from django.db import models
from django.contrib.auth import get_user_model

User = get_user_model()


class DashboardMetric(models.Model):

    metric_name = models.CharField(
        max_length=255
    )

    metric_value = models.FloatField(
        default=0
    )

    updated_at = models.DateTimeField(
        auto_now=True
    )

    def __str__(self):
        return self.metric_name


class StudentAnalytics(models.Model):

    student = models.ForeignKey(
        User,
        on_delete=models.CASCADE
    )

    total_courses = models.IntegerField(
        default=0
    )

    completed_courses = models.IntegerField(
        default=0
    )

    total_watch_time = models.IntegerField(
        default=0
    )

    learning_streak = models.IntegerField(
        default=0
    )

    total_points = models.IntegerField(
        default=0
    )

    updated_at = models.DateTimeField(
        auto_now=True
    )

    def __str__(self):
        return self.student.username


class InstructorAnalytics(models.Model):

    instructor = models.ForeignKey(
        User,
        on_delete=models.CASCADE
    )

    total_courses = models.IntegerField(
        default=0
    )

    total_students = models.IntegerField(
        default=0
    )

    total_revenue = models.FloatField(
        default=0
    )

    average_rating = models.FloatField(
        default=0
    )

    updated_at = models.DateTimeField(
        auto_now=True
    )

    def __str__(self):
        return self.instructor.username
PY

# serializers.py
cat > $BASE/serializers.py << 'PY'
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
PY

# services.py
cat > $BASE/services.py << 'PY'
from .models import (
    StudentAnalytics,
    InstructorAnalytics
)


class DashboardService:

    @staticmethod
    def update_student_stats(
        student,
        points=0,
        watch_time=0
    ):

        analytics, created = (
            StudentAnalytics.objects.get_or_create(
                student=student
            )
        )

        analytics.total_points += points

        analytics.total_watch_time += watch_time

        analytics.save()

        return analytics

    @staticmethod
    def update_instructor_revenue(
        instructor,
        revenue=0
    ):

        analytics, created = (
            InstructorAnalytics.objects.get_or_create(
                instructor=instructor
            )
        )

        analytics.total_revenue += revenue

        analytics.save()

        return analytics
PY

# charts.py
cat > $BASE/charts.py << 'PY'
def generate_learning_chart(data):

    labels = []
    values = []

    for item in data:

        labels.append(item['label'])

        values.append(item['value'])

    return {
        'labels': labels,
        'values': values
    }
PY

# views.py
cat > $BASE/views.py << 'PY'
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
PY

# urls.py
cat > $BASE/urls.py << 'PY'
from django.urls import path

from .views import (
    DashboardMetricsView,
    StudentAnalyticsView,
    InstructorAnalyticsView
)

urlpatterns = [

    path(
        'metrics/',
        DashboardMetricsView.as_view(),
        name='dashboard-metrics'
    ),

    path(
        'student/',
        StudentAnalyticsView.as_view(),
        name='student-analytics'
    ),

    path(
        'instructor/',
        InstructorAnalyticsView.as_view(),
        name='instructor-analytics'
    ),
]
PY

# tests.py
cat > $BASE/tests.py << 'PY'
from django.test import TestCase
from django.contrib.auth import get_user_model

from .models import (
    DashboardMetric
)

User = get_user_model()


class DashboardTestCase(TestCase):

    def setUp(self):

        self.metric = DashboardMetric.objects.create(
            metric_name='Total Users',
            metric_value=500
        )

    def test_metric_created(self):

        self.assertEqual(
            self.metric.metric_name,
            'Total Users'
        )

    def test_metric_value(self):

        self.assertEqual(
            self.metric.metric_value,
            500
        )
PY

chmod +x $BASE/setup_dashboard.sh

echo "✅ Dashboard module generated successfully"

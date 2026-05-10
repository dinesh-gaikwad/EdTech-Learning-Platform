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

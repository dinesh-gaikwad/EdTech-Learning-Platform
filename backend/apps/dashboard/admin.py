from django.contrib import admin

from .models import (
    DashboardMetric,
    StudentAnalytics,
    InstructorAnalytics
)

admin.site.register(DashboardMetric)
admin.site.register(StudentAnalytics)
admin.site.register(InstructorAnalytics)

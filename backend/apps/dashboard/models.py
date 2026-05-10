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

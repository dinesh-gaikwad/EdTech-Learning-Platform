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

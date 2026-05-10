from django.contrib import admin

from .models import (
    AIRecommendation,
    LearningPrediction,
    StudentBehavior
)

admin.site.register(AIRecommendation)
admin.site.register(LearningPrediction)
admin.site.register(StudentBehavior)

from django.test import TestCase
from django.contrib.auth import get_user_model

from .models import (
    AIRecommendation
)

User = get_user_model()


class AIEngineTestCase(TestCase):

    def setUp(self):

        self.user = User.objects.create_user(
            username='dinesh',
            password='StrongPassword123'
        )

        self.recommendation = (
            AIRecommendation.objects.create(
                user=self.user,
                recommended_course='Advanced Python',
                recommendation_score=0.95
            )
        )

    def test_recommendation_created(self):

        self.assertEqual(
            self.recommendation.recommended_course,
            'Advanced Python'
        )

    def test_recommendation_score(self):

        self.assertEqual(
            self.recommendation.recommendation_score,
            0.95
        )

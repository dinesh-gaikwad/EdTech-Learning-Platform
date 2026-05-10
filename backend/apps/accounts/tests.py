# /workspaces/EdTech-Learning-Platform/backend/apps/accounts/tests.py

from django.test import TestCase
from django.contrib.auth import get_user_model

from .models import (
    UserSkill,
    UserActivity
)

User = get_user_model()


class AccountsTestCase(TestCase):

    def setUp(self):

        self.user = User.objects.create_user(
            username='dinesh',
            email='dinesh@gmail.com',
            password='StrongPassword123'
        )

    def test_user_created(self):

        self.assertEqual(
            self.user.username,
            'dinesh'
        )

    def test_add_points(self):

        self.user.total_points = 100

        self.user.save()

        self.assertEqual(
            self.user.total_points,
            100
        )

    def test_skill_creation(self):

        skill = UserSkill.objects.create(
            user=self.user,
            skill_name='Python',
            level=5
        )

        self.assertEqual(
            skill.skill_name,
            'Python'
        )

    def test_activity_creation(self):

        activity = UserActivity.objects.create(
            user=self.user,
            activity_type='Login',
            description='User logged in'
        )

        self.assertEqual(
            activity.activity_type,
            'Login'
        )

    def test_profile_completion(self):

        self.user.first_name = 'Dinesh'
        self.user.last_name = 'Gaikwad'

        self.user.save()

        self.assertTrue(
            self.user.first_name == 'Dinesh'
        )
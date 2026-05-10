# /workspaces/EdTech-Learning-Platform/backend/apps/accounts/services.py

from django.contrib.auth import get_user_model

from .models import (
    UserActivity,
    UserNotification
)

User = get_user_model()


class UserService:

    @staticmethod
    def increase_points(user, points):

        user.total_points += points

        user.save()

        return user

    @staticmethod
    def increase_streak(user):

        user.learning_streak += 1

        user.save()

        return user

    @staticmethod
    def complete_course(user):

        user.completed_courses += 1

        user.total_points += 50

        user.save()

        return user

    @staticmethod
    def mark_verified(user):

        user.is_verified = True

        user.save()

        return user

    @staticmethod
    def mark_premium(user):

        user.is_premium = True

        user.save()

        return user

    @staticmethod
    def create_notification(
        user,
        title,
        message
    ):

        return UserNotification.objects.create(
            user=user,
            title=title,
            message=message
        )

    @staticmethod
    def log_activity(
        user,
        activity_type,
        description
    ):

        return UserActivity.objects.create(
            user=user,
            activity_type=activity_type,
            description=description
        )
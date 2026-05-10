from datetime import timedelta

from django.utils import timezone

from apps.courses.models import (
    Course,
)

from apps.accounts.models import (
    User,
)


def total_students():

    return User.objects.filter(
        is_active=True
    ).count()


def total_courses():

    return Course.objects.count()


def active_users_last_7_days():

    last_week = (
        timezone.now() -
        timedelta(days=7)
    )

    return User.objects.filter(
        last_login__gte=last_week
    ).count()


def completion_rate(
    completed,
    total
):

    if total == 0:

        return 0

    return round(
        (completed / total) * 100,
        2
    )


def student_growth_rate(
    current_month,
    previous_month
):

    if previous_month == 0:

        return 100

    growth = (
        (
            current_month -
            previous_month
        ) / previous_month
    ) * 100

    return round(growth, 2)


def course_popularity_score(
    enrollments,
    ratings,
    completions
):

    score = (
        enrollments * 0.5 +
        ratings * 0.3 +
        completions * 0.2
    )

    return round(score, 2)


def dashboard_metrics():

    metrics = {

        "students":
            total_students(),

        "courses":
            total_courses(),

        "active_users":
            active_users_last_7_days(),

        "completion_rate":
            completion_rate(
                350,
                500
            ),

        "growth_rate":
            student_growth_rate(
                1200,
                900
            ),
    }

    return metrics

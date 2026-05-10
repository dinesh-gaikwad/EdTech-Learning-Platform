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

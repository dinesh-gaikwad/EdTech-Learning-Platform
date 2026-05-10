from .metrics import (
    dashboard_metrics,
    course_popularity_score,
)

from apps.courses.models import (
    Course,
)


class AnalyticsService:

    @staticmethod
    def get_dashboard_data():

        return dashboard_metrics()

    @staticmethod
    def generate_course_rankings():

        rankings = []

        courses = Course.objects.all()

        for course in courses:

            enrollments = getattr(
                course,
                "total_enrollments",
                100
            )

            ratings = getattr(
                course,
                "average_rating",
                4.5
            )

            completions = getattr(
                course,
                "completed_students",
                50
            )

            score = (
                course_popularity_score(
                    enrollments,
                    ratings,
                    completions
                )
            )

            rankings.append({

                "course":
                    course.title,

                "score":
                    score
            })

        rankings.sort(
            key=lambda x: x["score"],
            reverse=True
        )

        return rankings

    @staticmethod
    def calculate_revenue(
        enrollments,
        course_price
    ):

        total = (
            enrollments *
            course_price
        )

        return round(total, 2)

    @staticmethod
    def monthly_report():

        return {

            "month":
                "May",

            "revenue":
                120000,

            "new_students":
                3500,

            "certificates":
                1400
        }

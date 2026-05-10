from django.test import TestCase

from .metrics import (
    completion_rate,
    student_growth_rate,
)

from .services import (
    AnalyticsService,
)


class AnalyticsMetricsTests(
    TestCase
):

    def test_completion_rate(self):

        result = completion_rate(
            80,
            100
        )

        self.assertEqual(
            result,
            80.0
        )

    def test_growth_rate(self):

        result = (
            student_growth_rate(
                120,
                100
            )
        )

        self.assertEqual(
            result,
            20.0
        )


class AnalyticsServiceTests(
    TestCase
):

    def test_revenue_calculation(self):

        total = (
            AnalyticsService
            .calculate_revenue(
                100,
                49.99
            )
        )

        self.assertEqual(
            total,
            4999.0
        )

    def test_monthly_report(self):

        report = (
            AnalyticsService
            .monthly_report()
        )

        self.assertIn(
            "revenue",
            report
        )

        self.assertIn(
            "new_students",
            report
        )

    def test_dashboard_data(self):

        data = (
            AnalyticsService
            .get_dashboard_data()
        )

        self.assertIn(
            "students",
            data
        )

        self.assertIn(
            "courses",
            data
        )

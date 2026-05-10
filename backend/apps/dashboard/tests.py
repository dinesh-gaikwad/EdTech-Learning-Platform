from django.test import TestCase
from django.contrib.auth import get_user_model

from .models import (
    DashboardMetric
)

User = get_user_model()


class DashboardTestCase(TestCase):

    def setUp(self):

        self.metric = DashboardMetric.objects.create(
            metric_name='Total Users',
            metric_value=500
        )

    def test_metric_created(self):

        self.assertEqual(
            self.metric.metric_name,
            'Total Users'
        )

    def test_metric_value(self):

        self.assertEqual(
            self.metric.metric_value,
            500
        )

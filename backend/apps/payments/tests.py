from django.test import TestCase
from django.contrib.auth import get_user_model

from .models import Payment

User = get_user_model()


class PaymentTestCase(TestCase):

    def setUp(self):

        self.user = User.objects.create_user(
            username='dinesh',
            password='StrongPassword123'
        )

        self.payment = Payment.objects.create(
            student=self.user,
            course_name='Python Mastery',
            amount=499
        )

    def test_payment_created(self):

        self.assertEqual(
            self.payment.course_name,
            'Python Mastery'
        )

    def test_payment_status(self):

        self.assertEqual(
            self.payment.status,
            'pending'
        )

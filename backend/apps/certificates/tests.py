from django.test import TestCase
from django.contrib.auth import get_user_model

from .models import Certificate

User = get_user_model()


class CertificateTestCase(TestCase):

    def setUp(self):

        self.user = User.objects.create_user(
            username='dinesh',
            password='StrongPassword123'
        )

        self.certificate = Certificate.objects.create(
            student=self.user,
            course_name='Python Mastery'
        )

    def test_certificate_created(self):

        self.assertEqual(
            self.certificate.course_name,
            'Python Mastery'
        )

    def test_certificate_verified(self):

        self.assertTrue(
            self.certificate.is_verified
        )

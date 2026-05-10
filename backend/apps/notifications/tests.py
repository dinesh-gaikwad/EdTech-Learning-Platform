from django.test import TestCase
from django.contrib.auth import get_user_model

from .models import Notification

User = get_user_model()


class NotificationTestCase(TestCase):

    def setUp(self):

        self.user = User.objects.create_user(
            username='dinesh',
            password='StrongPassword123'
        )

        self.notification = Notification.objects.create(
            user=self.user,
            title='Welcome',
            message='Welcome to EdTech Platform'
        )

    def test_notification_created(self):

        self.assertEqual(
            self.notification.title,
            'Welcome'
        )

    def test_notification_unread(self):

        self.assertFalse(
            self.notification.is_read
        )

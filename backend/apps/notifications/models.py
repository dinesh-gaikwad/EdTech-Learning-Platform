from django.db import models
from django.contrib.auth import get_user_model

User = get_user_model()


class Notification(models.Model):

    NOTIFICATION_TYPES = (
        ('course', 'Course'),
        ('payment', 'Payment'),
        ('community', 'Community'),
        ('certificate', 'Certificate'),
    )

    user = models.ForeignKey(
        User,
        on_delete=models.CASCADE
    )

    title = models.CharField(
        max_length=255
    )

    message = models.TextField()

    notification_type = models.CharField(
        max_length=50,
        choices=NOTIFICATION_TYPES,
        default='course'
    )

    is_read = models.BooleanField(
        default=False
    )

    created_at = models.DateTimeField(
        auto_now_add=True
    )

    def __str__(self):
        return self.title


class EmailNotification(models.Model):

    user = models.ForeignKey(
        User,
        on_delete=models.CASCADE
    )

    subject = models.CharField(
        max_length=255
    )

    body = models.TextField()

    sent = models.BooleanField(
        default=False
    )

    sent_at = models.DateTimeField(
        null=True,
        blank=True
    )

    created_at = models.DateTimeField(
        auto_now_add=True
    )

    def __str__(self):
        return self.subject


class PushNotification(models.Model):

    user = models.ForeignKey(
        User,
        on_delete=models.CASCADE
    )

    title = models.CharField(
        max_length=255
    )

    body = models.TextField()

    device_token = models.CharField(
        max_length=500
    )

    sent = models.BooleanField(
        default=False
    )

    created_at = models.DateTimeField(
        auto_now_add=True
    )

    def __str__(self):
        return self.title

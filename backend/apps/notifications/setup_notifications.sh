#!/bin/bash

set -e

BASE="/workspaces/EdTech-Learning-Platform/backend/apps/notifications"

mkdir -p $BASE/migrations

touch $BASE/migrations/__init__.py

# __init__.py
cat > $BASE/__init__.py << 'PY'
default_app_config = 'notifications.apps.NotificationsConfig'
PY

# apps.py
cat > $BASE/apps.py << 'PY'
from django.apps import AppConfig


class NotificationsConfig(AppConfig):
    default_auto_field = 'django.db.models.BigAutoField'
    name = 'notifications'
    verbose_name = 'Notifications Center'
PY

# admin.py
cat > $BASE/admin.py << 'PY'
from django.contrib import admin

from .models import (
    Notification,
    EmailNotification,
    PushNotification
)

admin.site.register(Notification)
admin.site.register(EmailNotification)
admin.site.register(PushNotification)
PY

# models.py
cat > $BASE/models.py << 'PY'
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
PY

# serializers.py
cat > $BASE/serializers.py << 'PY'
from rest_framework import serializers

from .models import (
    Notification,
    EmailNotification,
    PushNotification
)


class NotificationSerializer(
    serializers.ModelSerializer
):

    class Meta:
        model = Notification
        fields = '__all__'


class EmailNotificationSerializer(
    serializers.ModelSerializer
):

    class Meta:
        model = EmailNotification
        fields = '__all__'


class PushNotificationSerializer(
    serializers.ModelSerializer
):

    class Meta:
        model = PushNotification
        fields = '__all__'
PY

# services.py
cat > $BASE/services.py << 'PY'
from django.core.mail import send_mail

from .models import (
    Notification,
    EmailNotification,
    PushNotification
)


class NotificationService:

    @staticmethod
    def create_notification(
        user,
        title,
        message,
        notification_type='course'
    ):

        return Notification.objects.create(
            user=user,
            title=title,
            message=message,
            notification_type=notification_type
        )

    @staticmethod
    def send_email_notification(
        user,
        subject,
        body
    ):

        email = EmailNotification.objects.create(
            user=user,
            subject=subject,
            body=body
        )

        send_mail(
            subject,
            body,
            'admin@edtech.com',
            [user.email],
            fail_silently=True
        )

        email.sent = True

        email.save()

        return email

    @staticmethod
    def send_push_notification(
        user,
        title,
        body,
        device_token
    ):

        push = PushNotification.objects.create(
            user=user,
            title=title,
            body=body,
            device_token=device_token,
            sent=True
        )

        return push
PY

# tasks.py
cat > $BASE/tasks.py << 'PY'
from celery import shared_task

from .services import NotificationService


@shared_task
def send_bulk_email(
    users,
    subject,
    body
):

    for user in users:

        NotificationService.send_email_notification(
            user,
            subject,
            body
        )

    return True
PY

# views.py
cat > $BASE/views.py << 'PY'
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework.permissions import (
    IsAuthenticated
)

from .models import (
    Notification
)

from .serializers import (
    NotificationSerializer
)


class NotificationListView(APIView):

    permission_classes = [IsAuthenticated]

    def get(self, request):

        notifications = Notification.objects.filter(
            user=request.user
        ).order_by('-created_at')

        serializer = NotificationSerializer(
            notifications,
            many=True
        )

        return Response(serializer.data)


class MarkAsReadView(APIView):

    permission_classes = [IsAuthenticated]

    def post(self, request, notification_id):

        notification = Notification.objects.get(
            id=notification_id,
            user=request.user
        )

        notification.is_read = True

        notification.save()

        serializer = NotificationSerializer(
            notification
        )

        return Response(serializer.data)
PY

# urls.py
cat > $BASE/urls.py << 'PY'
from django.urls import path

from .views import (
    NotificationListView,
    MarkAsReadView
)

urlpatterns = [

    path(
        '',
        NotificationListView.as_view(),
        name='notifications'
    ),

    path(
        '<int:notification_id>/read/',
        MarkAsReadView.as_view(),
        name='notification-read'
    ),
]
PY

# tests.py
cat > $BASE/tests.py << 'PY'
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
PY

chmod +x $BASE/setup_notifications.sh

echo "✅ Notifications module generated successfully"

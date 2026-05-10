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

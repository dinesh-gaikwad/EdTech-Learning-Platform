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

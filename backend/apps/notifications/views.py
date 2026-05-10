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

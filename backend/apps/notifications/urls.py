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

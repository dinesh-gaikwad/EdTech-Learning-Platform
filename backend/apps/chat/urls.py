from django.urls import path

from .views import (
    RoomListView,
    RoomMessagesView,
    CreateRoomView
)

urlpatterns = [

    path(
        '',
        RoomListView.as_view(),
        name='room-list'
    ),

    path(
        'create/',
        CreateRoomView.as_view(),
        name='room-create'
    ),

    path(
        '<slug:room_slug>/messages/',
        RoomMessagesView.as_view(),
        name='room-messages'
    ),
]

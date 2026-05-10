#!/bin/bash

set -e

BASE="/workspaces/EdTech-Learning-Platform/backend/apps/chat"

mkdir -p $BASE/migrations

touch $BASE/migrations/__init__.py

# __init__.py
cat > $BASE/__init__.py << 'PY'
default_app_config = 'chat.apps.ChatConfig'
PY

# apps.py
cat > $BASE/apps.py << 'PY'
from django.apps import AppConfig


class ChatConfig(AppConfig):
    default_auto_field = 'django.db.models.BigAutoField'
    name = 'chat'
    verbose_name = 'Realtime Chat System'
PY

# admin.py
cat > $BASE/admin.py << 'PY'
from django.contrib import admin

from .models import (
    ChatRoom,
    Message
)

admin.site.register(ChatRoom)
admin.site.register(Message)
PY

# models.py
cat > $BASE/models.py << 'PY'
from django.db import models
from django.contrib.auth import get_user_model

User = get_user_model()


class ChatRoom(models.Model):

    name = models.CharField(max_length=255)

    room_slug = models.SlugField(unique=True)

    created_by = models.ForeignKey(
        User,
        on_delete=models.CASCADE
    )

    created_at = models.DateTimeField(
        auto_now_add=True
    )

    def __str__(self):
        return self.name


class Message(models.Model):

    room = models.ForeignKey(
        ChatRoom,
        on_delete=models.CASCADE,
        related_name='messages'
    )

    sender = models.ForeignKey(
        User,
        on_delete=models.CASCADE
    )

    message = models.TextField()

    is_edited = models.BooleanField(default=False)

    sent_at = models.DateTimeField(
        auto_now_add=True
    )

    def __str__(self):
        return f'{self.sender.username} - {self.room.name}'
PY

# serializers.py
cat > $BASE/serializers.py << 'PY'
from rest_framework import serializers

from .models import (
    ChatRoom,
    Message
)


class ChatRoomSerializer(serializers.ModelSerializer):

    class Meta:
        model = ChatRoom
        fields = '__all__'


class MessageSerializer(serializers.ModelSerializer):

    class Meta:
        model = Message
        fields = '__all__'
PY

# consumers.py
cat > $BASE/consumers.py << 'PY'
import json

from channels.generic.websocket import AsyncWebsocketConsumer


class ChatConsumer(AsyncWebsocketConsumer):

    async def connect(self):

        self.room_name = self.scope[
            'url_route'
        ]['kwargs']['room_name']

        self.room_group_name = (
            f'chat_{self.room_name}'
        )

        await self.channel_layer.group_add(
            self.room_group_name,
            self.channel_name
        )

        await self.accept()

    async def disconnect(
        self,
        close_code
    ):

        await self.channel_layer.group_discard(
            self.room_group_name,
            self.channel_name
        )

    async def receive(
        self,
        text_data
    ):

        data = json.loads(text_data)

        message = data['message']

        username = data['username']

        await self.channel_layer.group_send(
            self.room_group_name,
            {
                'type': 'chat_message',
                'message': message,
                'username': username
            }
        )

    async def chat_message(
        self,
        event
    ):

        await self.send(
            text_data=json.dumps({
                'message': event['message'],
                'username': event['username']
            })
        )
PY

# routing.py
cat > $BASE/routing.py << 'PY'
from django.urls import re_path

from .consumers import ChatConsumer

websocket_urlpatterns = [

    re_path(
        r'ws/chat/(?P<room_name>\w+)/$',
        ChatConsumer.as_asgi()
    ),
]
PY

# services.py
cat > $BASE/services.py << 'PY'
from .models import (
    ChatRoom,
    Message
)


class ChatService:

    @staticmethod
    def create_room(
        name,
        slug,
        user
    ):

        room = ChatRoom.objects.create(
            name=name,
            room_slug=slug,
            created_by=user
        )

        return room

    @staticmethod
    def send_message(
        room,
        sender,
        message
    ):

        msg = Message.objects.create(
            room=room,
            sender=sender,
            message=message
        )

        return msg
PY

# views.py
cat > $BASE/views.py << 'PY'
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework.permissions import (
    IsAuthenticated,
    AllowAny
)

from .models import (
    ChatRoom,
    Message
)

from .serializers import (
    ChatRoomSerializer,
    MessageSerializer
)


class RoomListView(APIView):

    permission_classes = [AllowAny]

    def get(self, request):

        rooms = ChatRoom.objects.all()

        serializer = ChatRoomSerializer(
            rooms,
            many=True
        )

        return Response(serializer.data)


class RoomMessagesView(APIView):

    permission_classes = [AllowAny]

    def get(self, request, room_slug):

        room = ChatRoom.objects.get(
            room_slug=room_slug
        )

        messages = Message.objects.filter(
            room=room
        )

        serializer = MessageSerializer(
            messages,
            many=True
        )

        return Response(serializer.data)


class CreateRoomView(APIView):

    permission_classes = [IsAuthenticated]

    def post(self, request):

        room = ChatRoom.objects.create(
            name=request.data.get('name'),
            room_slug=request.data.get('slug'),
            created_by=request.user
        )

        serializer = ChatRoomSerializer(room)

        return Response(serializer.data)
PY

# urls.py
cat > $BASE/urls.py << 'PY'
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
PY

# tests.py
cat > $BASE/tests.py << 'PY'
from django.test import TestCase
from django.contrib.auth import get_user_model

from .models import (
    ChatRoom,
    Message
)

User = get_user_model()


class ChatTestCase(TestCase):

    def setUp(self):

        self.user = User.objects.create_user(
            username='dinesh',
            password='StrongPassword123'
        )

        self.room = ChatRoom.objects.create(
            name='Python Room',
            room_slug='python-room',
            created_by=self.user
        )

        self.message = Message.objects.create(
            room=self.room,
            sender=self.user,
            message='Hello World'
        )

    def test_room_created(self):

        self.assertEqual(
            self.room.name,
            'Python Room'
        )

    def test_message_created(self):

        self.assertEqual(
            self.message.message,
            'Hello World'
        )
PY

chmod +x $BASE/setup_chat.sh

echo "✅ Chat module generated successfully"

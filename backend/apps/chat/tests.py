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

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

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

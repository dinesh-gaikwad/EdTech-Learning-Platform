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

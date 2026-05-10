from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework.permissions import (
    IsAuthenticated,
    AllowAny
)

from .models import (
    DiscussionPost,
    Comment,
    CommunityGroup
)

from .serializers import (
    DiscussionPostSerializer,
    CommentSerializer,
    CommunityGroupSerializer
)


class GroupListView(APIView):

    permission_classes = [AllowAny]

    def get(self, request):

        groups = CommunityGroup.objects.all()

        serializer = CommunityGroupSerializer(
            groups,
            many=True
        )

        return Response(serializer.data)


class PostListView(APIView):

    permission_classes = [AllowAny]

    def get(self, request):

        posts = DiscussionPost.objects.all().order_by(
            '-created_at'
        )

        serializer = DiscussionPostSerializer(
            posts,
            many=True
        )

        return Response(serializer.data)


class CreatePostView(APIView):

    permission_classes = [IsAuthenticated]

    def post(self, request):

        group = CommunityGroup.objects.get(
            id=request.data.get('group')
        )

        post = DiscussionPost.objects.create(
            author=request.user,
            group=group,
            title=request.data.get('title'),
            content=request.data.get('content')
        )

        serializer = DiscussionPostSerializer(
            post
        )

        return Response(serializer.data)


class CommentView(APIView):

    permission_classes = [IsAuthenticated]

    def post(self, request, post_id):

        post = DiscussionPost.objects.get(
            id=post_id
        )

        comment = Comment.objects.create(
            post=post,
            user=request.user,
            content=request.data.get('content')
        )

        serializer = CommentSerializer(
            comment
        )

        return Response(serializer.data)

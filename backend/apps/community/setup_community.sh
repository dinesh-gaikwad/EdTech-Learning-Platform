#!/bin/bash

set -e

BASE="/workspaces/EdTech-Learning-Platform/backend/apps/community"

mkdir -p $BASE/migrations

touch $BASE/migrations/__init__.py

# __init__.py
cat > $BASE/__init__.py << 'PY'
default_app_config = 'community.apps.CommunityConfig'
PY

# apps.py
cat > $BASE/apps.py << 'PY'
from django.apps import AppConfig


class CommunityConfig(AppConfig):
    default_auto_field = 'django.db.models.BigAutoField'
    name = 'community'
    verbose_name = 'Student Community'
PY

# admin.py
cat > $BASE/admin.py << 'PY'
from django.contrib import admin

from .models import (
    DiscussionPost,
    Comment,
    Like,
    CommunityGroup
)

admin.site.register(DiscussionPost)
admin.site.register(Comment)
admin.site.register(Like)
admin.site.register(CommunityGroup)
PY

# models.py
cat > $BASE/models.py << 'PY'
from django.db import models
from django.contrib.auth import get_user_model

User = get_user_model()


class CommunityGroup(models.Model):

    name = models.CharField(
        max_length=255
    )

    description = models.TextField()

    created_by = models.ForeignKey(
        User,
        on_delete=models.CASCADE
    )

    created_at = models.DateTimeField(
        auto_now_add=True
    )

    def __str__(self):
        return self.name


class DiscussionPost(models.Model):

    author = models.ForeignKey(
        User,
        on_delete=models.CASCADE
    )

    group = models.ForeignKey(
        CommunityGroup,
        on_delete=models.CASCADE,
        related_name='posts'
    )

    title = models.CharField(
        max_length=255
    )

    content = models.TextField()

    image = models.ImageField(
        upload_to='community/',
        blank=True,
        null=True
    )

    total_likes = models.IntegerField(
        default=0
    )

    created_at = models.DateTimeField(
        auto_now_add=True
    )

    def __str__(self):
        return self.title


class Comment(models.Model):

    post = models.ForeignKey(
        DiscussionPost,
        on_delete=models.CASCADE,
        related_name='comments'
    )

    user = models.ForeignKey(
        User,
        on_delete=models.CASCADE
    )

    content = models.TextField()

    created_at = models.DateTimeField(
        auto_now_add=True
    )

    def __str__(self):
        return self.user.username


class Like(models.Model):

    post = models.ForeignKey(
        DiscussionPost,
        on_delete=models.CASCADE
    )

    user = models.ForeignKey(
        User,
        on_delete=models.CASCADE
    )

    created_at = models.DateTimeField(
        auto_now_add=True
    )

    class Meta:
        unique_together = (
            'post',
            'user'
        )

    def __str__(self):
        return self.user.username
PY

# serializers.py
cat > $BASE/serializers.py << 'PY'
from rest_framework import serializers

from .models import (
    DiscussionPost,
    Comment,
    Like,
    CommunityGroup
)


class CommunityGroupSerializer(
    serializers.ModelSerializer
):

    class Meta:
        model = CommunityGroup
        fields = '__all__'


class CommentSerializer(
    serializers.ModelSerializer
):

    class Meta:
        model = Comment
        fields = '__all__'


class LikeSerializer(
    serializers.ModelSerializer
):

    class Meta:
        model = Like
        fields = '__all__'


class DiscussionPostSerializer(
    serializers.ModelSerializer
):

    comments = CommentSerializer(
        many=True,
        read_only=True
    )

    class Meta:
        model = DiscussionPost
        fields = '__all__'
PY

# services.py
cat > $BASE/services.py << 'PY'
from .models import (
    Like,
    DiscussionPost
)


class CommunityService:

    @staticmethod
    def like_post(
        user,
        post
    ):

        like, created = Like.objects.get_or_create(
            user=user,
            post=post
        )

        if created:

            post.total_likes += 1

            post.save()

        return like

    @staticmethod
    def create_post(
        user,
        group,
        title,
        content
    ):

        post = DiscussionPost.objects.create(
            author=user,
            group=group,
            title=title,
            content=content
        )

        return post
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
PY

# urls.py
cat > $BASE/urls.py << 'PY'
from django.urls import path

from .views import (
    GroupListView,
    PostListView,
    CreatePostView,
    CommentView
)

urlpatterns = [

    path(
        'groups/',
        GroupListView.as_view(),
        name='community-groups'
    ),

    path(
        'posts/',
        PostListView.as_view(),
        name='community-posts'
    ),

    path(
        'posts/create/',
        CreatePostView.as_view(),
        name='community-create-post'
    ),

    path(
        'posts/<int:post_id>/comment/',
        CommentView.as_view(),
        name='community-comment'
    ),
]
PY

# tests.py
cat > $BASE/tests.py << 'PY'
from django.test import TestCase
from django.contrib.auth import get_user_model

from .models import (
    CommunityGroup,
    DiscussionPost
)

User = get_user_model()


class CommunityTestCase(TestCase):

    def setUp(self):

        self.user = User.objects.create_user(
            username='dinesh',
            password='StrongPassword123'
        )

        self.group = CommunityGroup.objects.create(
            name='Python Developers',
            description='Python Community',
            created_by=self.user
        )

        self.post = DiscussionPost.objects.create(
            author=self.user,
            group=self.group,
            title='Welcome',
            content='Welcome to community'
        )

    def test_group_created(self):

        self.assertEqual(
            self.group.name,
            'Python Developers'
        )

    def test_post_created(self):

        self.assertEqual(
            self.post.title,
            'Welcome'
        )
PY

chmod +x $BASE/setup_community.sh

echo "✅ Community module generated successfully"

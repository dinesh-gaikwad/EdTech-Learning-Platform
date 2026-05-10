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

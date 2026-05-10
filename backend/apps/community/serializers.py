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

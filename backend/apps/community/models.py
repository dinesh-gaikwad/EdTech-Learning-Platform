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

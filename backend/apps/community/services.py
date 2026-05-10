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

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

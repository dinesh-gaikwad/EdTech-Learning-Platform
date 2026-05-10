# /workspaces/EdTech-Learning-Platform/backend/apps/accounts/models.py

from django.contrib.auth.models import AbstractUser
from django.db import models
from django.utils import timezone


class User(AbstractUser):

    ROLE_CHOICES = (
        ('student', 'Student'),
        ('instructor', 'Instructor'),
        ('admin', 'Admin'),
    )

    role = models.CharField(
        max_length=20,
        choices=ROLE_CHOICES,
        default='student'
    )

    profile_picture = models.ImageField(
        upload_to='profiles/',
        blank=True,
        null=True
    )

    cover_image = models.ImageField(
        upload_to='covers/',
        blank=True,
        null=True
    )

    bio = models.TextField(blank=True)

    github_url = models.URLField(blank=True)
    linkedin_url = models.URLField(blank=True)
    portfolio_url = models.URLField(blank=True)

    learning_streak = models.IntegerField(default=0)
    total_points = models.IntegerField(default=0)
    completed_courses = models.IntegerField(default=0)

    country = models.CharField(max_length=100, blank=True)
    city = models.CharField(max_length=100, blank=True)

    is_verified = models.BooleanField(default=False)
    is_premium = models.BooleanField(default=False)

    last_activity = models.DateTimeField(default=timezone.now)

    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return f'{self.username} ({self.role})'

    @property
    def full_name(self):
        return f'{self.first_name} {self.last_name}'.strip()

    def add_points(self, points):
        self.total_points += points
        self.save()

    def increase_streak(self):
        self.learning_streak += 1
        self.save()

    def mark_verified(self):
        self.is_verified = True
        self.save()

    def mark_premium(self):
        self.is_premium = True
        self.save()


class UserActivity(models.Model):

    user = models.ForeignKey(
        User,
        on_delete=models.CASCADE,
        related_name='activities'
    )

    activity_type = models.CharField(max_length=255)

    description = models.TextField()

    ip_address = models.GenericIPAddressField(
        null=True,
        blank=True
    )

    device = models.CharField(
        max_length=255,
        blank=True
    )

    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        ordering = ['-created_at']

    def __str__(self):
        return f'{self.user.username} - {self.activity_type}'


class UserSkill(models.Model):

    user = models.ForeignKey(
        User,
        on_delete=models.CASCADE,
        related_name='skills'
    )

    skill_name = models.CharField(max_length=255)

    level = models.IntegerField(default=1)

    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f'{self.user.username} - {self.skill_name}'


class UserNotification(models.Model):

    user = models.ForeignKey(
        User,
        on_delete=models.CASCADE
    )

    title = models.CharField(max_length=255)

    message = models.TextField()

    is_read = models.BooleanField(default=False)

    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.title
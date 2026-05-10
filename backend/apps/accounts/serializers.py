# /workspaces/EdTech-Learning-Platform/backend/apps/accounts/serializers.py

from rest_framework import serializers
from django.contrib.auth import get_user_model
from django.contrib.auth.password_validation import validate_password

from .models import (
    UserSkill,
    UserActivity,
    UserNotification
)

User = get_user_model()


class UserSkillSerializer(serializers.ModelSerializer):

    class Meta:
        model = UserSkill
        fields = '__all__'


class UserActivitySerializer(serializers.ModelSerializer):

    class Meta:
        model = UserActivity
        fields = '__all__'


class NotificationSerializer(serializers.ModelSerializer):

    class Meta:
        model = UserNotification
        fields = '__all__'


class UserSerializer(serializers.ModelSerializer):

    skills = UserSkillSerializer(many=True, read_only=True)

    class Meta:
        model = User
        exclude = ['password']


class RegisterSerializer(serializers.ModelSerializer):

    password = serializers.CharField(write_only=True)

    confirm_password = serializers.CharField(write_only=True)

    class Meta:
        model = User
        fields = [
            'username',
            'email',
            'password',
            'confirm_password',
            'role'
        ]

    def validate(self, attrs):

        if attrs['password'] != attrs['confirm_password']:
            raise serializers.ValidationError(
                'Passwords do not match'
            )

        validate_password(attrs['password'])

        return attrs

    def create(self, validated_data):

        validated_data.pop('confirm_password')

        user = User.objects.create_user(
            username=validated_data['username'],
            email=validated_data['email'],
            password=validated_data['password'],
            role=validated_data.get('role', 'student')
        )

        return user


class LoginSerializer(serializers.Serializer):

    username = serializers.CharField()

    password = serializers.CharField()


class UpdateProfileSerializer(serializers.ModelSerializer):

    class Meta:
        model = User

        fields = [
            'first_name',
            'last_name',
            'bio',
            'github_url',
            'linkedin_url',
            'portfolio_url',
            'country',
            'city',
            'profile_picture',
            'cover_image'
        ]
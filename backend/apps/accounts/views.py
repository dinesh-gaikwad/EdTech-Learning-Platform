# /workspaces/EdTech-Learning-Platform/backend/apps/accounts/views.py

from django.contrib.auth import authenticate
from django.contrib.auth import get_user_model
from django.db.models import Sum
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework.permissions import (
    IsAuthenticated,
    AllowAny
)
from rest_framework import status

from .models import (
    UserActivity,
    UserSkill,
    UserNotification
)

from .serializers import (
    RegisterSerializer,
    LoginSerializer,
    UserSerializer,
    UpdateProfileSerializer,
    UserActivitySerializer,
    UserSkillSerializer,
    NotificationSerializer
)

User = get_user_model()


class RegisterView(APIView):

    permission_classes = [AllowAny]

    def post(self, request):

        serializer = RegisterSerializer(
            data=request.data
        )

        if serializer.is_valid():

            user = serializer.save()

            UserActivity.objects.create(
                user=user,
                activity_type='Account Created',
                description='New student registered'
            )

            return Response({
                'success': True,
                'message': 'Account created successfully',
                'user': UserSerializer(user).data
            }, status=status.HTTP_201_CREATED)

        return Response(
            serializer.errors,
            status=status.HTTP_400_BAD_REQUEST
        )


class LoginView(APIView):

    permission_classes = [AllowAny]

    def post(self, request):

        serializer = LoginSerializer(
            data=request.data
        )

        if serializer.is_valid():

            username = serializer.validated_data['username']
            password = serializer.validated_data['password']

            user = authenticate(
                username=username,
                password=password
            )

            if user:

                UserActivity.objects.create(
                    user=user,
                    activity_type='Login',
                    description='User logged into platform'
                )

                return Response({
                    'success': True,
                    'message': 'Login successful',
                    'user': UserSerializer(user).data
                })

            return Response({
                'success': False,
                'message': 'Invalid credentials'
            }, status=status.HTTP_401_UNAUTHORIZED)

        return Response(
            serializer.errors,
            status=status.HTTP_400_BAD_REQUEST
        )


class ProfileView(APIView):

    permission_classes = [IsAuthenticated]

    def get(self, request):

        serializer = UserSerializer(request.user)

        return Response({
            'success': True,
            'data': serializer.data
        })

    def put(self, request):

        serializer = UpdateProfileSerializer(
            request.user,
            data=request.data,
            partial=True
        )

        if serializer.is_valid():

            serializer.save()

            UserActivity.objects.create(
                user=request.user,
                activity_type='Profile Updated',
                description='User updated profile'
            )

            return Response({
                'success': True,
                'message': 'Profile updated',
                'data': serializer.data
            })

        return Response(
            serializer.errors,
            status=status.HTTP_400_BAD_REQUEST
        )


class LeaderboardView(APIView):

    permission_classes = [AllowAny]

    def get(self, request):

        users = User.objects.all().order_by(
            '-total_points'
        )[:20]

        serializer = UserSerializer(
            users,
            many=True
        )

        return Response({
            'success': True,
            'count': users.count(),
            'results': serializer.data
        })


class ActivityView(APIView):

    permission_classes = [IsAuthenticated]

    def get(self, request):

        activities = UserActivity.objects.filter(
            user=request.user
        )

        serializer = UserActivitySerializer(
            activities,
            many=True
        )

        return Response({
            'success': True,
            'results': serializer.data
        })


class SkillView(APIView):

    permission_classes = [IsAuthenticated]

    def get(self, request):

        skills = UserSkill.objects.filter(
            user=request.user
        )

        serializer = UserSkillSerializer(
            skills,
            many=True
        )

        return Response({
            'success': True,
            'results': serializer.data
        })

    def post(self, request):

        serializer = UserSkillSerializer(
            data=request.data
        )

        if serializer.is_valid():

            serializer.save(
                user=request.user
            )

            return Response({
                'success': True,
                'message': 'Skill added successfully',
                'data': serializer.data
            })

        return Response(
            serializer.errors,
            status=status.HTTP_400_BAD_REQUEST
        )


class NotificationView(APIView):

    permission_classes = [IsAuthenticated]

    def get(self, request):

        notifications = UserNotification.objects.filter(
            user=request.user
        ).order_by('-created_at')

        serializer = NotificationSerializer(
            notifications,
            many=True
        )

        return Response({
            'success': True,
            'results': serializer.data
        })


class DashboardStatsView(APIView):

    permission_classes = [IsAuthenticated]

    def get(self, request):

        user = request.user

        stats = {
            'total_points': user.total_points,
            'learning_streak': user.learning_streak,
            'completed_courses': user.completed_courses,
            'skills_count': UserSkill.objects.filter(
                user=user
            ).count(),
            'activities_count': UserActivity.objects.filter(
                user=user
            ).count()
        }

        return Response({
            'success': True,
            'stats': stats
        })
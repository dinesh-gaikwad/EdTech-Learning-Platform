from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework.permissions import (
    IsAuthenticated,
    AllowAny
)

from .models import (
    Course,
    Enrollment,
    Review
)

from .serializers import (
    CourseSerializer,
    EnrollmentSerializer,
    ReviewSerializer
)


class CourseListView(APIView):

    permission_classes = [AllowAny]

    def get(self, request):

        courses = Course.objects.filter(
            is_published=True
        )

        serializer = CourseSerializer(
            courses,
            many=True
        )

        return Response(serializer.data)


class CourseDetailView(APIView):

    permission_classes = [AllowAny]

    def get(self, request, pk):

        course = Course.objects.get(pk=pk)

        serializer = CourseSerializer(course)

        return Response(serializer.data)


class EnrollView(APIView):

    permission_classes = [IsAuthenticated]

    def post(self, request, pk):

        course = Course.objects.get(pk=pk)

        enrollment, created = Enrollment.objects.get_or_create(
            student=request.user,
            course=course
        )

        serializer = EnrollmentSerializer(enrollment)

        return Response(serializer.data)


class ReviewView(APIView):

    permission_classes = [IsAuthenticated]

    def post(self, request, pk):

        course = Course.objects.get(pk=pk)

        review = Review.objects.create(
            student=request.user,
            course=course,
            rating=request.data.get('rating'),
            comment=request.data.get('comment')
        )

        serializer = ReviewSerializer(review)

        return Response(serializer.data)

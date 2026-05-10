from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework.permissions import (
    IsAuthenticated,
    AllowAny
)

from .models import Certificate
from .serializers import CertificateSerializer
from .services import CertificateService


class CertificateListView(APIView):

    permission_classes = [IsAuthenticated]

    def get(self, request):

        certificates = Certificate.objects.filter(
            student=request.user
        )

        serializer = CertificateSerializer(
            certificates,
            many=True
        )

        return Response(serializer.data)


class GenerateCertificateView(APIView):

    permission_classes = [IsAuthenticated]

    def post(self, request):

        course_name = request.data.get(
            'course_name'
        )

        certificate = CertificateService.generate_certificate(
            request.user,
            course_name
        )

        serializer = CertificateSerializer(
            certificate
        )

        return Response(serializer.data)


class VerifyCertificateView(APIView):

    permission_classes = [AllowAny]

    def get(self, request, certificate_id):

        certificate = Certificate.objects.get(
            certificate_id=certificate_id
        )

        serializer = CertificateSerializer(
            certificate
        )

        return Response(serializer.data)

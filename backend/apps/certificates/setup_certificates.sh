#!/bin/bash

set -e

BASE="/workspaces/EdTech-Learning-Platform/backend/apps/certificates"

mkdir -p $BASE/migrations

touch $BASE/migrations/__init__.py

# __init__.py
cat > $BASE/__init__.py << 'PY'
default_app_config = 'certificates.apps.CertificatesConfig'
PY

# apps.py
cat > $BASE/apps.py << 'PY'
from django.apps import AppConfig


class CertificatesConfig(AppConfig):
    default_auto_field = 'django.db.models.BigAutoField'
    name = 'certificates'
    verbose_name = 'Certificate Engine'
PY

# admin.py
cat > $BASE/admin.py << 'PY'
from django.contrib import admin
from .models import Certificate

admin.site.register(Certificate)
PY

# models.py
cat > $BASE/models.py << 'PY'
from django.db import models
from django.contrib.auth import get_user_model
import uuid

User = get_user_model()


class Certificate(models.Model):

    student = models.ForeignKey(
        User,
        on_delete=models.CASCADE
    )

    course_name = models.CharField(max_length=255)

    certificate_id = models.UUIDField(
        default=uuid.uuid4,
        editable=False,
        unique=True
    )

    issued_date = models.DateTimeField(
        auto_now_add=True
    )

    pdf_file = models.FileField(
        upload_to='certificates/',
        blank=True,
        null=True
    )

    is_verified = models.BooleanField(default=True)

    def __str__(self):
        return f'{self.student.username} - {self.course_name}'
PY

# serializers.py
cat > $BASE/serializers.py << 'PY'
from rest_framework import serializers
from .models import Certificate


class CertificateSerializer(serializers.ModelSerializer):

    class Meta:
        model = Certificate
        fields = '__all__'
PY

# services.py
cat > $BASE/services.py << 'PY'
from .models import Certificate


class CertificateService:

    @staticmethod
    def generate_certificate(
        student,
        course_name
    ):

        certificate = Certificate.objects.create(
            student=student,
            course_name=course_name
        )

        return certificate
PY

# pdf_generator.py
cat > $BASE/pdf_generator.py << 'PY'
from reportlab.pdfgen import canvas


def generate_pdf(path, student_name, course_name):

    c = canvas.Canvas(path)

    c.setFont("Helvetica-Bold", 28)

    c.drawString(
        100,
        750,
        "Certificate of Completion"
    )

    c.setFont("Helvetica", 18)

    c.drawString(
        100,
        680,
        f"Presented to: {student_name}"
    )

    c.drawString(
        100,
        640,
        f"For completing: {course_name}"
    )

    c.save()
PY

# views.py
cat > $BASE/views.py << 'PY'
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
PY

# urls.py
cat > $BASE/urls.py << 'PY'
from django.urls import path

from .views import (
    CertificateListView,
    GenerateCertificateView,
    VerifyCertificateView
)

urlpatterns = [

    path(
        '',
        CertificateListView.as_view(),
        name='certificate-list'
    ),

    path(
        'generate/',
        GenerateCertificateView.as_view(),
        name='certificate-generate'
    ),

    path(
        'verify/<uuid:certificate_id>/',
        VerifyCertificateView.as_view(),
        name='certificate-verify'
    ),
]
PY

# tests.py
cat > $BASE/tests.py << 'PY'
from django.test import TestCase
from django.contrib.auth import get_user_model

from .models import Certificate

User = get_user_model()


class CertificateTestCase(TestCase):

    def setUp(self):

        self.user = User.objects.create_user(
            username='dinesh',
            password='StrongPassword123'
        )

        self.certificate = Certificate.objects.create(
            student=self.user,
            course_name='Python Mastery'
        )

    def test_certificate_created(self):

        self.assertEqual(
            self.certificate.course_name,
            'Python Mastery'
        )

    def test_certificate_verified(self):

        self.assertTrue(
            self.certificate.is_verified
        )
PY

chmod +x $BASE/setup_certificates.sh

echo "✅ Certificates module generated successfully"

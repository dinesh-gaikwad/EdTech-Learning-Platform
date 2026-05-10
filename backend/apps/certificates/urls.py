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

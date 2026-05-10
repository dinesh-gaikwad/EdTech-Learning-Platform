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

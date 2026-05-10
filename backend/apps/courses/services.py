from .models import Enrollment


class CourseService:

    @staticmethod
    def enroll_student(student, course):

        enrollment, created = Enrollment.objects.get_or_create(
            student=student,
            course=course
        )

        return enrollment

    @staticmethod
    def complete_course(enrollment):

        enrollment.completed = True
        enrollment.progress = 100
        enrollment.save()

        return enrollment

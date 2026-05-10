from django.apps import AppConfig


class CoursesConfig(AppConfig):
    default_auto_field = 'django.db.models.BigAutoField'
    name = 'courses'
    verbose_name = 'Courses & Learning Platform'

    def ready(self):
        try:
            import courses.signals
        except Exception:
            pass

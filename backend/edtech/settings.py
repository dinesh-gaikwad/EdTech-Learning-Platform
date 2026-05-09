import os
from pathlib import Path
from decouple import config
BASE_DIR = Path(__file__).resolve().parent.parent
SECRET_KEY = config('SECRET_KEY', default='dev-secret-2026')
DEBUG = config('DEBUG', default=True, cast=bool)
ALLOWED_HOSTS = ['*']
INSTALLED_APPS = ['django.contrib.admin','django.contrib.auth','django.contrib.contenttypes','django.contrib.sessions','django.contrib.messages','django.contrib.staticfiles','rest_framework','rest_framework_simplejwt','oauth2_provider','corsheaders','edtech.apps.users','edtech.apps.courses','edtech.apps.certificates','edtech.apps.ai_mentor']
MIDDLEWARE = ['corsheaders.middleware.CorsMiddleware','django.middleware.security.SecurityMiddleware','django.contrib.sessions.middleware.SessionMiddleware','django.middleware.common.CommonMiddleware','django.middleware.csrf.CsrfViewMiddleware','django.contrib.auth.middleware.AuthenticationMiddleware','django.contrib.messages.middleware.MessageMiddleware']
ROOT_URLCONF = 'edtech.urls'
DATABASES = {'default': {'ENGINE': 'django.db.backends.mysql','NAME': 'edtech_db','USER': 'root','PASSWORD': 'rootpass2026','HOST': 'mysql','PORT': '3306'}}
STATIC_URL = '/static/'
MEDIA_URL = '/media/'
MEDIA_ROOT = BASE_DIR / 'media'
DEFAULT_AUTO_FIELD = 'django.db.models.BigAutoField'
REST_FRAMEWORK = {'DEFAULT_AUTHENTICATION_CLASSES': ('rest_framework_simplejwt.authentication.JWTAuthentication','oauth2_provider.contrib.rest_framework.OAuth2Authentication',)}
CORS_ALLOWED_ORIGINS = ['http://localhost:3000']
STEP_LOCK_MIN_SCORE = 80
OLLAMA_URL = config('OLLAMA_URL', default='http://localhost:11434/api/generate')

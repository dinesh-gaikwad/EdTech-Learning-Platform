from django.contrib import admin
from django.urls import path, include
urlpatterns = [path('admin/', admin.site.urls),path('api/auth/', include('edtech.apps.users.urls')),path('api/courses/', include('edtech.apps.courses.urls')),path('api/certificates/', include('edtech.apps.certificates.urls')),path('api/ai/', include('edtech.apps.ai_mentor.urls'))]

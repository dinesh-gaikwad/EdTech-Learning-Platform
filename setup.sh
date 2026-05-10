#!/bin/bash

set -e

echo "🚀 Creating Microsoft-Level EdTech Learning Platform..."

mkdir -p \
backend/apps/accounts/migrations \
backend/apps/courses/migrations \
backend/apps/payments/migrations \
backend/apps/certificates/migrations \
backend/apps/analytics/migrations \
backend/apps/chat/migrations \
backend/apps/dashboard/migrations \
backend/apps/notifications/migrations \
backend/apps/ai_engine/migrations \
backend/apps/community/migrations \
backend/config/settings \
backend/templates/emails \
backend/templates/certificates \
backend/static/css \
backend/static/js \
backend/static/images \
backend/media/uploads \
backend/scripts \
frontend/public \
frontend/src/api \
frontend/src/components/common \
frontend/src/components/auth \
frontend/src/components/dashboard \
frontend/src/components/courses \
frontend/src/components/certificates \
frontend/src/components/community \
frontend/src/components/chat \
frontend/src/components/payments \
frontend/src/components/layout \
frontend/src/components/threejs \
frontend/src/pages \
frontend/src/hooks \
frontend/src/context \
frontend/src/store \
frontend/src/utils \
frontend/src/styles \
frontend/src/assets/icons \
frontend/src/assets/images \
frontend/src/routes \
frontend/src/services \
frontend/src/animations \
frontend/src/tests \
docker/nginx \
docker/postgres \
docs/api \
docs/architecture \
github/workflows \
infra/terraform \
infra/kubernetes \
logs

# Root files

touch README.md \
.env \
.gitignore \
docker-compose.yml \
Makefile

# Backend files

touch backend/manage.py \
backend/requirements.txt \
backend/Dockerfile \
backend/config/__init__.py \
backend/config/asgi.py \
backend/config/wsgi.py \
backend/config/urls.py \
backend/config/celery.py \
backend/config/settings/__init__.py \
backend/config/settings/base.py \
backend/config/settings/dev.py \
backend/config/settings/prod.py

# Accounts app

touch backend/apps/accounts/__init__.py \
python manage.py runserver
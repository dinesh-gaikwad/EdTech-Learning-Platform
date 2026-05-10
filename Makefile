# =========================================================
# Microsoft-Level EdTech Learning Platform Makefile
# =========================================================

PROJECT_NAME=EdTech-Learning-Platform

# =========================================================
# Docker Commands
# =========================================================

up:
	docker-compose up --build

down:
	docker-compose down

restart:
	docker-compose down
	docker-compose up --build

logs:
	docker-compose logs -f

ps:
	docker-compose ps

# =========================================================
# Backend Commands
# =========================================================

backend:
	cd backend && python manage.py runserver

migrations:
	cd backend && python manage.py makemigrations

migrate:
	cd backend && python manage.py migrate

superuser:
	cd backend && python manage.py createsuperuser

shell:
	cd backend && python manage.py shell

test:
	cd backend && python manage.py test

collectstatic:
	cd backend && python manage.py collectstatic --noinput

# =========================================================
# Frontend Commands
# =========================================================

frontend:
	cd frontend && npm run dev

frontend-install:
	cd frontend && npm install

frontend-build:
	cd frontend && npm run build

# =========================================================
# Celery Commands
# =========================================================

celery:
	cd backend && celery -A config worker -l info

celery-beat:
	cd backend && celery -A config beat -l info

# =========================================================
# Database Commands
# =========================================================

mysql:
	docker exec -it edtech_mysql mysql -u root -p

redis:
	docker exec -it edtech_redis redis-cli

# =========================================================
# Cleanup Commands
# =========================================================

clean:
	find . -name "__pycache__" -exec rm -rf {} +
	find . -name "*.pyc" -delete
	find . -name "*.pyo" -delete

reset-db:
	docker-compose down -v

reset-frontend:
	cd frontend && rm -rf node_modules package-lock.json

reset-backend:
	find backend -name "migrations" -type d | xargs rm -rf

# =========================================================
# Install Commands
# =========================================================

install-backend:
	cd backend && pip install -r requirements.txt

install-all:
	make install-backend
	make frontend-install

# =========================================================
# Production Commands
# =========================================================

prod-build:
	docker-compose -f docker-compose.yml build

prod-up:
	docker-compose -f docker-compose.yml up -d

prod-down:
	docker-compose -f docker-compose.yml down

# =========================================================
# Status
# =========================================================

status:
	@echo "===================================="
	@echo "EdTech Learning Platform Status"
	@echo "===================================="
	@docker-compose ps
	@echo "===================================="

# =========================================================
# Help Menu
# =========================================================

help:
	@echo ""
	@echo "==============================================="
	@echo " Microsoft-Level EdTech Platform Commands"
	@echo "==============================================="
	@echo ""
	@echo " make up                 -> Start all containers"
	@echo " make down               -> Stop all containers"
	@echo " make restart            -> Restart full project"
	@echo " make logs               -> View logs"
	@echo " make backend            -> Run Django server"
	@echo " make frontend           -> Run React frontend"
	@echo " make migrate            -> Apply migrations"
	@echo " make migrations         -> Create migrations"
	@echo " make superuser          -> Create Django admin"
	@echo " make celery             -> Start celery worker"
	@echo " make mysql              -> Open MySQL shell"
	@echo " make redis              -> Open Redis CLI"
	@echo " make test               -> Run tests"
	@echo " make clean              -> Clean cache files"
	@echo " make install-all        -> Install dependencies"
	@echo " make status             -> Container status"
	@echo ""
	@echo "==============================================="
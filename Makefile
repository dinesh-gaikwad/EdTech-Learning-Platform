.PHONY: setup run stop clean migrate seed pull-ai
setup:
	@cp.env.example.env
	@docker-compose build --no-cache
	@docker-compose up -d mysql redis ollama
	@sleep 20
	@docker-compose run --rm backend python manage.py migrate
	@echo "✅ Setup Complete! Frontend: http://localhost:3000"
run:
	@docker-compose up -d
stop:
	@docker-compose down
clean:
	@docker-compose down -v
	@rm -rf backend/edtech/migrations/ backend/media/ frontend/dist/
migrate:
	@docker-compose run --rm backend python manage.py makemigrations
	@docker-compose run --rm backend python manage.py migrate
seed:
	@docker-compose run --rm backend python manage.py seed_demo_data
pull-ai:
	@docker-compose exec ollama ollama pull llama3.2:3b

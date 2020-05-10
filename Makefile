up:
	docker-compose up -d

up-build:
	docker-compose up -d --build

down:
	docker-compose down

down-rm:
	docker-compose down -v --rmi all

app:
	docker-compose exec app bash

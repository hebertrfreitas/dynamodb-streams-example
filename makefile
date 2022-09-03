.PHONY: up down

## Up the docker compose
up: 
	docker-compose up

## Shut down the service and any associated volume
down:
	docker-compose down --volumes
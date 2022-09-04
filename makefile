LAMBDA_FILE := lambda/users-lambda.py


.PHONY: up down lambda-zip

## Up the docker compose
up: 
	docker-compose up

## Shut down the service and any associated volume
down:
	docker-compose down --volumes

## create a zip with the python script
lambda-zip:
	zip -j docker/lambda/users-lambda.zip $(LAMBDA_FILE)
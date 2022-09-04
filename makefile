LAMBDA_FILE := lambda/users_lambda.py


.PHONY: up down lambda-zip

## Up the docker compose
up: lambda-zip
	docker-compose up

## Shut down the service and any associated volume
down:
	docker-compose down --volumes

## create virtual environment and install pip dependecies
lambda-setup:
	rm -rf lambda/.venv; \
	python3 -m venv lambda/.venv; \
	source lambda/.venv/bin/activate; \
	pip install -r lambda/requirements.txt;
	

## create a zip with the python script
lambda-zip:
	zip -j docker/lambda/users-lambda.zip $(LAMBDA_FILE) lambda/requirements.txt



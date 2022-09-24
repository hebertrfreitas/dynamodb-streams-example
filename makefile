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
	rm -rf lambda/package; \
	python3 -m venv lambda/.venv; \
	source lambda/.venv/bin/activate; \
	pip install -r lambda/requirements.txt; \
	deactivate;
	
## create a zip with the python script
lambda-zip:
	cd lambda/.venv/lib/python3.8/site-packages/; \
	zip -r ../../../../../docker/lambda/users-lambda.zip .; \
	cd ../../../../; \
	zip -g ../docker/lambda/users-lambda.zip users_lambda.py requirements.txt;
##	zip -j docker/lambda/users-lambda.zip lambda/users_lambda.py lambda/requirements.txt; \
##	zip -ur docker/lambda/users-lambda.zip lambda/package/; 




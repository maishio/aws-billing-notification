ACCOUNT := 123456789012
ENV := myEnv
REGION := us-east-1
SERVICE := myService

.PHONY: tasks

tasks:
	@echo Usage: make [task]
	@echo --------------------
	@echo
	@cat Makefile
	@echo

build:
	time docker build --platform=linux/amd64 -t ${ACCOUNT}.dkr.ecr.${REGION}.amazonaws.com/${SERVICE}-${ENV}-notify-aws-billing:latest --target production .
	# time docker build -t ${ACCOUNT}.dkr.ecr.${REGION}.amazonaws.com/${SERVICE}-${ENV}-notify-aws-billing:latest --target production .

build-prod:
	make build
	make push

clean:
	docker ps -a | xargs docker rm -f; \
	docker images | xargs docker rmi -f; \
	docker builder prune -f

push:
	aws ecr get-login-password --region ${REGION} | docker login --username AWS --password-stdin ${ACCOUNT}.dkr.ecr.${REGION}.amazonaws.com
	time docker push ${ACCOUNT}.dkr.ecr.${REGION}.amazonaws.com/${SERVICE}-${ENV}-notify-aws-billing:latest

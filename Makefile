SHELL:=/bin/bash
PROJECT_DIR = $(shell pwd)
REGION = us-east-1
ECR_BASE_URL = 049712246386.dkr.ecr.$(REGION).amazonaws.com
ECR_REPO_NAME = mti/aws-lambda-docker-test

all: help
targets: build deploy 

.PHONY : targets
.DEFAULT : help


#~
login: #~
#~ Builds docker image
login: ecr-login

ecr-login:
	@echo -e "\n Logging into ECR... \n"
	aws ecr get-login-password --region "$(REGION)" | docker login --username AWS --password-stdin "$(ECR_BASE_URL)"
	@echo -e "\n Done! \n"


#~
image: #~
#~ Builds docker image
image: image-build

image-build:
	@echo -e "\n Building docker image... \n"
	docker build -t $(ECR_REPO_NAME) .
	docker tag $(ECR_REPO_NAME):latest $(ECR_BASE_URL)/$(ECR_REPO_NAME):latest
	@echo -e "\n Done! \n"

#~
run: #~
#~ Run latest docker image in local repo
run: image-run

image-run:
	@echo -e "\n Running docker image on port 9000... \n"
	docker run -p 9000:8080 $(ECR_REPO_NAME)


#~
publish: #~
#~ Builds docker publish
publish: login image-publish

image-publish:
	@echo -e "\n Publishing docker image to ecr... \n"
	docker push ${ECR_BASE_URL}/${ECR_REPO_NAME}:latest
	@echo -e "\n Done! \n"


#~
deploy: #~
#~ Show this help.
deploy: deploy
	@echo "Deploy"


print-ver:
	@echo -e "****************************************************************************"
	@echo -e "IMAGE: "
	@echo -e "****************************************************************************"



#~
help: #~
#~ Show this help.
	@echo -e "\nusage: make [target] \n"
	@fgrep -h "#~" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/\#~/   /' | sed -e 's/\(^[^#~].*\)/    \1/'
	@echo -e "\n\n\n"

	
# import deploy config.

dpl ?= deploy.env
include $(dpl)
export $(shell sed 's/=.*//' $(dpl))

# Get the short git commit hash:
VERSION=$(shell ./version.sh)

# DOCKER TASKS
# Build the container
build: ## Build the container
	docker build -t $(APP_NAME) .

run: ## Run container on port configured in `deploy.env`
	docker run --rm -i -t -p=$(PORT):$(PORT) --name="$(APP_NAME)" $(APP_NAME)

stop: ## Stop and remove a running container
	docker stop $(APP_NAME); docker rm $(APP_NAME)

# Docker tagging
tag: tag-version tag-latest ## Generate container tag for VERSION tag

tag-version: ## Generate container `version` tag
	@echo 'create tag $(VERSION)'
	docker tag $(APP_NAME) $(DOCKER_REPO)/$(APP_NAME):$(VERSION)

tag-latest: ## Generate container `latest` tag
	@echo 'create tag latest'
	docker tag $(APP_NAME) $(DOCKER_REPO)/$(APP_NAME):latest

# Docker upload
upload: repo-login upload-latest upload-version ## Publish the `{version}` and `latest` tagged containers

upload-latest: tag-latest ## Publish the `latest` taged container
	@echo 'upload latest to $(DOCKER_REPO)'
	docker push $(DOCKER_REPO)/$(APP_NAME):latest

upload-version: tag-version ## Publish the `{version}` taged container
	@echo 'upload $(VERSION) to $(DOCKER_REPO)'
	docker push $(DOCKER_REPO)/$(APP_NAME):$(VERSION)

# login to Docker Hub
repo-login: ## Login to docker hub
	docker login

lint:
	#hadolint Dockerfile
	docker run --rm -i hadolint/hadolint < Dockerfile
	pylint app.py

k8s-deploy: # Deploy to kubernetes
	ssh -T master "kubectl apply -f btcroc/develop/btcroc-deploy.yaml"
	ssh -T master "kubectl set image -n develop deployment/btcroc-deployment btcroc=donko/btcroc:${VERSION}"

version: ## Output the current version
	@echo $(VERSION)

all: lint build

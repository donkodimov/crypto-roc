build:
	#docker build -t donko/btcroc:v0.1 .
	sh run_docker.sh

upload:
	sh upload_docker.sh

lint:
	#hadolint Dockerfile
	docker run --rm -i hadolint/hadolint < Dockerfile
	pylint app.py
	#tidy -q -e templates/index.html

all: lint build
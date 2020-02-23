DOCKER_REVISION ?= kafka-$(USER)
DOCKER_TAG = docker-push.ocf.berkeley.edu/kafka:$(DOCKER_REVISION)

dev: cook-image
	docker run --rm "$(DOCKER_TAG)" /bin/sh

cook-image:
	docker build --pull -t $(DOCKER_TAG) . -f Dockerfile

push-image:
	docker push $(DOCKER_TAG)

.PHONY: dev cook-image push-image

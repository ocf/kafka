DOCKER_REVISION ?= kafka-$(USER)
DOCKER_TAG = docker-push.ocf.berkeley.edu/kafka:$(DOCKER_REVISION)
KM_DOCKER_TAG = docker-push.ocf.berkeley.edu/kafka-manager:$(DOCKER_REVISION)

dev: cook-image
	docker run --rm "$(DOCKER_TAG)" /bin/sh
	docker run --rm "$(KM_DOCKER_TAG)" /bin/sh

cook-image:
	docker build --pull -t $(DOCKER_TAG) . -f Dockerfile
	docker build --pull -t $(KM_DOCKER_TAG) . -f Dockerfile.kafka_manager

push-image:
	docker push $(DOCKER_TAG)
	docker push $(KM_DOCKER_TAG)

.PHONY: dev cook-image push-image

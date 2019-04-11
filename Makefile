DOCKER_REVISION ?= kafka-k8s-testing-$(USER)
DOCKER_TAG = docker-push.ocf.berkeley.edu/kafka-k8s:$(DOCKER_REVISION)
RANDOM_PORT := $(shell expr $$(( 8000 + (`id -u` % 1000) + 2 )))

GF_VERSION := 6.0.0

dev: cook-image
	docker run --rm "$(DOCKER_TAG)" /bin/sh

cook-image:
	docker build --pull -t $(DOCKER_TAG) .

push-image:
	docker push $(DOCKER_TAG)

.PHONY: dev cook-image push-image

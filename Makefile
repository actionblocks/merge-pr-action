IMAGE_NAME=merge-pr-action
DOCKER_REPO=actionblocks

.PHONY: lint
	`npm bin`/tslint --project ./tsconfig.json --fix

.PHONY: deps
deps:
	npm i

.PHONY: prebuild
prebuild:
	rm -rf build
	mkdir -p build

.PHONY: build
build: prebuild
	`npm bin`/tsc
	chmod +x ./build/merge-pr-action.js

.PHONY: run
run:
	node --no-deprecation ./build/merge-pr-action.js

.PHONY: test
test:
	EVENT_FILE=./fixtures/event.json ./entrypoint.sh

.PHONE: docker-build
docker-build:
	docker build -t $(IMAGE_NAME) .

.PHONY: docker-tag
docker-tag:
	tag $(IMAGE_NAME) $(DOCKER_REPO)/$(IMAGE_NAME) --no-latest --no-sha

.PHONY: docker-publish
docker-publish:
	docker push $(DOCKER_REPO)/$(IMAGE_NAME)


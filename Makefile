container_name := golang
container_registry := quay.io/nordstrom
golang_version := 1.6.2
golang_download_sha := e40c36ae71756198478624ed1bb4ce17597b3c19d243f3f0899bb5740d56212a
container_release := $(golang_version)

.PHONY: build/image tag/image push/image

build/image:
	docker build \
		--build-arg GOLANG_VERSION=$(golang_version) \
		--build-arg GOLANG_DOWNLOAD_SHA256=$(golang_download_sha) \
		--build-arg http_proxy=http://webproxysea.nordstrom.net:8181 \
		--build-arg https_proxy=http://webproxysea.nordstrom.net:8181 \
		-t $(container_name) .

tag/image: build/image
	docker tag $(container_name) $(container_registry)/$(container_name):$(container_release)

push/image: tag/image
	docker push $(container_registry)/$(container_name):$(container_release)
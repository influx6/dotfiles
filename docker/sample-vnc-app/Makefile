VERSION?=latest

build:
	docker build -t influx6/intelij-u:${VERSION} .

push:
	docker push influx6/intelij-u:latest

deploy: build push
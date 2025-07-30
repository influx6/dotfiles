VERSION?=latest

build:
	docker build -f Dockerfile.light -t influx6/novnc-light:${VERSION} .
	docker tag influx6/novnc-light:${VERSION} influx6/novnc-light:latest
	docker build -f Dockerfile -t influx6/novnc:${VERSION} .
	docker tag influx6/novnc:${VERSION} influx6/novnc:latest

push:
	docker push influx6/novnc:${VERSION}
	docker push influx6/novnc-light:${VERSION}
	docker push influx6/novnc:latest
	docker push influx6/novnc-light:latest

deploy: build push
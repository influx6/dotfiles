DIR?=$(shell pwd)
VERSION?=0.0.5

build:
	cd ${DIR}/novnc && make build VERSION=${VERSION} && cd -
	cd ${DIR}/intellij && make build VERSION=${VERSION} && cd -

push:
	cd ${DIR}/novnc && make push VERSION=${VERSION} && cd -
	cd ${DIR}/intellij && make push VERSION=${VERSION} && cd -

deploy:
	cd ${DIR}/novnc && make deploy VERSION=${VERSION} && cd -
	cd ${DIR}/intellij && make deploy VERSION=${VERSION} && cd -

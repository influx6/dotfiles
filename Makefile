CURRENT_TIME:=$(shell date +%s)
PWD:=$(shell pwd)
LOG_FILE?="ansible_${CURRENT_TIME}.output"
LOG?=false
BOOK?=""
VERBOSITY=-vv

ANSIBLE_ROOT_DIR=${PWD}/ansible/
ANSIBLE_HOSTS?="${PWD}/ansible/hosts/metal.yml"

define deploy_book
	$(if $(($(LOG),true)),(ansible-playbook ${VERBOSITY} -i ${ANSIBLE_HOSTS} "${ANSIBLE_ROOT_DIR}/playbooks/$1.yml" | tee ${LOG_FILE}),(ansible-playbook ${VERBOSITY} -i ${ANSIBLE_HOSTS} ${ANSIBLE_ROOT_DIR}/playbooks/$1.yml))
endef

deploy_group:
	$(call deploy_book,groups/${BOOK})

deploy_play:
	$(call deploy_book,plays/${BOOK})

docker:
	$(call deploy_book,groups/docker)

k8s:
	$(call deploy_book,groups/k8s)

dotfiles:
	$(call deploy_book,groups/dotfiles)

all:
	$(call deploy_book,groups/all)

unraid:
	$(call deploy_book,plays/unraid)

shutdown:
	$(call deploy_book,plays/shutdown)

hello:
	$(call deploy_book,plays/hello)

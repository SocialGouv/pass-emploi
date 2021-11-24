#OUTSIDE CONTAINER

build:
	docker build -t ansible-vault .
run-vault: build
	#docker run --rm -it -v $(pwd):/ansible ansible-vault /bin/bash
	./vault.sh

#INSIDE CONTAINER
decrypt-staging:
	ansible-vault view --ask-vault-pass staging.env > staging.secret

edit-staging:
	ansible-vault edit --ask-vault-pass staging.env


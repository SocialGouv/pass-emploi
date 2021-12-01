#OUTSIDE CONTAINER

build:
	docker build -t ansible-vault .
	
run-vault: build
	./vault.sh

#INSIDE CONTAINER
decrypt-staging:
	ansible-vault view --ask-vault-pass staging.env > staging.secret

edit-staging:
	ansible-vault edit --ask-vault-pass staging.env

decrypt-prod:
	ansible-vault view --ask-vault-pass prod.env > prod.secret

edit-prod:
	ansible-vault edit --ask-vault-pass prod.env

## create vault
## ansible-vault create myFile

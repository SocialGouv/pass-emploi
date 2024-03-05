#OUTSIDE CONTAINER

build:
	docker build -t ansible-vault .
	
run-vault: build
	./vault.sh

#INSIDE CONTAINER
decrypt-staging:
	ansible-vault view --ask-vault-pass staging.secret > staging.env

edit-staging:
	ansible-vault edit --ask-vault-pass staging.secret

decrypt-prod:
	ansible-vault view --ask-vault-pass prod.secret > prod.env

edit-prod:
	ansible-vault edit --ask-vault-pass prod.secret

## with secret file
decrypt-staging-f:
	ansible-vault view --vault-password-file staging.key staging.secret > staging.env

edit-staging-f:
	ansible-vault edit --vault-password-file staging.key staging.secret

decrypt-prod-f:
	ansible-vault view --vault-password-file prod.key prod.secret > prod.env

edit-prod-f:
	ansible-vault edit --vault-password-file prod.key prod.secret

## create vault
## ansible-vault create myFile

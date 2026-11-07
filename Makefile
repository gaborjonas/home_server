.PHONY: lint lint-terraform lint-ansible lint-secrets

lint: lint-terraform lint-ansible lint-secrets

lint-terraform:
	cd terraform && terraform fmt -check -recursive
	cd terraform && terraform init -backend=false
	cd terraform && terraform validate
	cd terraform && tflint --init
	cd terraform && tflint

lint-ansible:
	cd ansible && ansible-lint --exclude deploy.yml

lint-secrets:
	gitleaks detect --source . --no-banner --redact

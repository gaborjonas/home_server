.PHONY: lint lint-terraform lint-ansible lint-yaml lint-secrets

lint: lint-terraform lint-ansible lint-yaml lint-secrets

lint-terraform:
	cd terraform && terraform fmt -check -recursive
	cd terraform && terraform init -backend=false
	cd terraform && terraform validate
	cd terraform && tflint --init
	cd terraform && tflint

lint-ansible:
	cd ansible && ansible-lint --exclude playbooks/deploy.yml

lint-yaml:
	yamllint .

lint-secrets:
	gitleaks detect --source . --no-banner --redact

tfvars_file = ddr.config

default: setup apply update-outputs status

setup:
	@ cd prereqs && terraform init && terraform apply -auto-approve -var-file="../${tfvars_file}"

apply:
	@ terraform init && terraform apply -auto-approve

update-outputs:
	@ cd outputs && terraform init && terraform apply -auto-approve -var-file="../${tfvars_file}"

status:
	@ cd outputs && terraform output -json

.PHONY: default setup apply update-outputs status

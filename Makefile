tfvars_file = ddr.config

default: doormat-login setup apply update-outputs status

check:
	@ for i in workspaces/*; do echo CHECKING $$i; cd $$i && terraform init && terraform validate && cd - && echo $$i LOOKS GOOD; done

doormat-login:
	@ doormat login -f && doormat aws cred-file add-profile --set-default --role $$(echo $$(doormat aws list) | awk '{ print $$3 }') && aws sts get-caller-identity | jq

setup:
	@ cd prereqs && terraform init && terraform apply -auto-approve -var-file="../${tfvars_file}"

apply:
	@ terraform init && terraform apply -auto-approve

update-outputs:
	@ cd outputs && terraform init && terraform apply -auto-approve -var-file="../${tfvars_file}"

status:
	@ cd outputs && terraform output -json

.PHONY: default check doormat-login setup apply update-outputs status

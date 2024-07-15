default: doormat-login setup apply

clean: destroy

check:
	@ for i in workspaces/*; do echo CHECKING $$i; cd $$i && terraform init -reconfigure && terraform validate; cd - ; done

destroy:
	@ terraform destroy

doormat-login:
	@ doormat login -f && doormat aws cred-file add-profile --set-default --role $$(echo $$(doormat aws list) | awk '{ print $$3 }') && aws sts get-caller-identity | jq

setup:
	@ cd prereqs && terraform init && terraform apply -auto-approve

apply:
	@ terraform init && terraform apply -auto-approve

.PHONY: default check doormat-login setup apply update-outputs status

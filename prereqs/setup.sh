#!/bin/bash

doormat-login() {
	doormat login -f
	doormat aws cred-file add-profile --set-default --role "$(echo $(doormat aws list) | awk '{ print $3 }')"
	aws sts get-caller-identity
}

terraform-apply() {
	terraform init
	terraform apply -auto-approve
}

terraform-destroy() {
	terraform destroy -auto-approve
}

doormat-login
terraform-apply

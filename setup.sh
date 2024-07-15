#!/bin/bash -e

tfvars_file="terraform.tfvars"

main() {

	check-terraform-variables
	fix-missing-variables

	# while [[ $# -gt 0 ]]; do
	# 	case "$1" in
	# 		doormat)
	# 			pushd prereqs
	# 			doormat-login
	# 			popd
	# 			;;
	# 		foo)
	# 			;;
	# 		-d|--destroy)
	# 			terraform-destroy
	# 			;;
	# 		-c|--check-variables)
	# 			check-terraform-variables
	# 			;;
	# 		*)
	# 			echo "Invalid option: $1" >&2
	# 			;;
	# 	esac
	# 	shift
	# done
}

doormat-login() {
	doormat login -f
	doormat aws cred-file add-profile --set-default --role "$(echo $(doormat aws list) | awk '{ print $3 }')"
}

terraform-apply() {
	terraform init
	terraform apply -auto-approve
}

terraform-destroy() {
	terraform
	destroy -auto-approve
}

check-terraform-variables() {
	local missing_variables=()
	local required_variables=(
		"oauth_token_id"
		"repo_identifier"
		"aws_account_id"
		"my_email"
		"region"
		"resource_prefix"
		"tfc_project_name"
		"tfc_organization"
		"tfc_token"
		"hcp_client_id"
		"hcp_client_secret"
		"hcp_project_id"
	)

	for variable in "${required_variables[@]}"; do
		if ! grep -q "^$variable" ${tfvars_file}; then
			missing_variables+=("$variable")
		else
			echo "Found variable: $variable"
		fi
	done

	if [ ${#missing_variables[@]} -gt 0 ]; then
		echo "Missing variables: ${missing_variables[*]}"
	fi
}



main "$@"

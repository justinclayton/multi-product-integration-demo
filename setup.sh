#!/bin/bash -e

main() {

	while check-terraform-variables

	check-terraform-variables
	fix-missing-variables


	while [[ $# -gt 0 ]]; do
		case "$1" in
			doormat)
				pushd prereqs
				doormat-login
				popd
				;;
			foo)
				;;
			-d|--destroy)
				terraform-destroy
				;;
			-c|--check-variables)
				check-terraform-variables
				;;
			*)
				echo "Invalid option: $1" >&2
				;;
		esac
		shift
	done
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
		"repo_branch"
		"aws_account_id"
		"my_email"
		"region"
		"resource_prefix"
		"tfc_project_name"
		"tfc_organization"
		"HCP_CLIENT_ID"
		"HCP_CLIENT_SECRET"
		"HCP_PROJECT_ID"
		"TFE_ORGANIZATION"
		"TFE_TOKEN"
	)

	for variable in "${required_variables[@]}"; do
		if ! grep -q "^$variable" prereqs/terraform.tfvars; then
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

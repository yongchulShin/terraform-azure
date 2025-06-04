. scripts/input-param.sh

terraform plan -out=plans/tfplan-vault -var-file=envs/${env}.tfvars -target=module.key_vault
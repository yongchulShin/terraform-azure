. scripts/input-param.sh

terraform plan -out=plans/tfplan-vnet -var-file=envs/${env}.tfvars -target=module.virtual_network
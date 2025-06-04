. scripts/input-param.sh

terraform plan -out=plans/tfplan-vm -var-file=envs/${env}.tfvars -target=module.virtual_machine
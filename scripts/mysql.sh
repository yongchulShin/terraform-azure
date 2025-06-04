. scripts/input-param.sh

terraform plan -out=plans/tfplan-mysql -var-file=envs/${env}.tfvars -target=module.mysql
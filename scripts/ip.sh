. scripts/input-param.sh

terraform plan -out=plans/tfplan-ip -var-file=envs/${env}.tfvars -target=module.ip
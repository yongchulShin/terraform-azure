. scripts/input-param.sh

terraform plan -out=plans/tfplan-peering -var-file=envs/${env}.tfvars -target=module.network_peering
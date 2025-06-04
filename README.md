# terraform

### install terraform
```
brew tap hashicorp/tap
brew install hashicorp/tap/terraform
```

### initialize terraform
```
terraform init
```

### select workspace (prod, dev)
```
terraform workspace select dev
```

### run plan (prod.tfvars, dev.tfvars *참조할 환경변수 파일을 선택해야 합니다.*)
```
terraform plan -out=tfplan -var-file=envs/dev.tfvars
```

### apply plan
terraform plan 명령어로 생성된 "tfplan" 파일을 기반으로 azure에 적용됩니다.
```
terraform apply "tfplan"
```

### 환경변수
terraform.tfvars 파일에 다음 값들이 정의되어야 합니다.
```
tenant_id                      = "my-tenant-id"
subscription_id                = "my-subscription-id"
common_subscription_id         = "my-common-subscription-id"
common_resource_group_name     = "my-common-resource-group-name"
common_application_gateway     = "common-network-gw"
ip_configuration_name          = "internal"
admin_username                 = "my-user-name"
ssh_key_name                   = "my-ssh-name"

subscription_name              = "my-subscription-name"
disk_size                      = 30
location                       = "Korea Central"
vnet_address_space             = "0.0.0.0/26"
subnet_prefix                  = "0.0.0.0/27"
vm_size                        = "Standard_D2s_v3"
mysql_flexible_server_sku_name = "B_Standard_B1ms"
mysql_admin_username           = "my-mysql-username"
mysql_admin_password           = "my-mysql-password"
resource_group_name            = "my-resource-group-name"
```

### destroy
destroy 명령어는 terraform에 의해 생성된 리소스를 제거합니다.
아래 명령어로 어떤 리소스가 제거될지 확인할 수 있습니다.
```
terraform plan -destroy
```
plan 명령어로 확인한 리소스를 제거합니다.
```
terraform destroy
```
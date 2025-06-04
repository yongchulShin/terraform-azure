# 🌩️ Terraform Azure 인프라 자동화 프로젝트

본 저장소는 Terraform을 활용하여 Azure 클라우드 인프라를 코드로 관리하는 IaC(Infrastructure as Code) 프로젝트입니다.  
환경별(개발/운영) 인프라 구성을 자동화하고, 일관된 방식으로 리소스를 관리할 수 있습니다.

## 🧩 프로젝트 구성

* `modules/`: 재사용 가능한 Terraform 모듈
* `plans/`: 환경별 Terraform 계획 파일
* `scripts/`: 유틸리티 스크립트
* `*.tf`: Terraform 설정 파일들

## 🛠 사용 기술

* Terraform
* Azure Cloud
* HCL (HashiCorp Configuration Language)
* Shell Script

## 🚀 시작하기

### 1. Terraform 설치
```bash
brew tap hashicorp/tap
brew install hashicorp/tap/terraform
```

### 2. 초기화
```bash
terraform init
```

### 3. 작업 환경 선택
```bash
terraform workspace select dev  # 개발 환경
# or
terraform workspace select prod  # 운영 환경
```

### 4. 계획 생성
```bash
terraform plan -out=tfplan -var-file=envs/dev.tfvars
```

### 5. 인프라 적용
```bash
terraform apply "tfplan"
```

## ⚙️ 환경 변수 설정

`terraform.tfvars` 파일에 다음 변수들을 정의해야 합니다:

```hcl
tenant_id                      = "my-tenant-id"
subscription_id                = "my-subscription-id"
common_subscription_id         = "my-common-subscription-id"
common_resource_group_name     = "my-common-resource-group-name"
common_application_gateway     = "common-network-gw"
ip_configuration_name          = "internal"
admin_username                 = "my-user-name"
ssh_key_name                  = "my-ssh-name"

subscription_name              = "my-subscription-name"
disk_size                     = 30
location                      = "Korea Central"
vnet_address_space            = "0.0.0.0/26"
subnet_prefix                 = "0.0.0.0/27"
vm_size                       = "Standard_D2s_v3"
mysql_flexible_server_sku_name = "B_Standard_B1ms"
mysql_admin_username          = "my-mysql-username"
mysql_admin_password          = "my-mysql-password"
resource_group_name           = "my-resource-group-name"
```

## 🧹 리소스 정리

### 삭제 계획 확인
```bash
terraform plan -destroy
```

### 리소스 삭제 실행
```bash
terraform destroy
```

## 🙋‍♂️ About Me

신용철 (Yongchul Shin)  
전 서든어택 프로게이머 → 백엔드 개발자  
GitHub: github.com/yongchulShin  
Email: prozernim@gmail.com

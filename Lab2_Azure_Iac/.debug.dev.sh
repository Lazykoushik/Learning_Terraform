# set the subscription id and access key for the backend storage account
export ARM_SUBSCRIPTION_ID="a716beb2-b2df-4736-9ddb-64b3dbaf82d7"
export ARM_ACCESS_KEY=$(az storage account keys list \
  --resource-group rg-Backend_tfstate-test \
  --account-name stterraformkjejh2um \
  --query "[0].value" -o tsv)

# Set the environment name and tags for the Terraform configuration

export TF_VAR_environment_name="dev"
export TF_VAR_tags="environment:${TF_VAR_environment_name}"
export TF_VAR_application_name="TerraformLab101"

# Terraform init

terraform init -reconfigure \
    -backend-config="resource_group_name=rg-Backend_tfstate-test" \
    -backend-config="storage_account_name=stterraformkjejh2um" \
    -backend-config="container_name=tfstate-files" \
    -backend-config="key=terraform.tfstate"

# Terraform workspace select or create the workspace for the environment

terraform workspace select "${TF_VAR_environment_name}" || terraform workspace new "${TF_VAR_environment_name}"

# Terraform plan and apply with the provided variables

terraform "$@"
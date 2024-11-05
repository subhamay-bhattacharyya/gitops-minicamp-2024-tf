## ---------------------------------------------------------------------------------------------------------------------
## Project Name                         - GitOps Minicamp 2024
## Project Description                  - GitOps Minicamp by Derek Morgan and Andrew Brown using GitHub
##                                        Actions and Terraform.
## Modification History:
##   - 1.0.0    Oct 20,2024 - Subhamay  - Initial Version
## ---------------------------------------------------------------------------------------------------------------------
# --- root/outputs.tf ---

output "resources" {
  value = {
    aws_environment = var.environment_name
    aws_region = data.aws_region.current.name
    aws_account_id = data.aws_caller_identity.current.account_id
    module_path = path.module
    networking = module.networking.outputs
    ec2_instances        = module.compute.outputs
  }
}

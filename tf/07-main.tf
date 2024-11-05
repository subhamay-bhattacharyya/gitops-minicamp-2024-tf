## ---------------------------------------------------------------------------------------------------------------------
## Project Name                         - GitOps Minicamp 2024
## Project Description                  - GitOps Minicamp by Derek Morgan and Andrew Brown using GitHub
##                                        Actions and Terraform.
## Modification History:
##   - 1.0.0    Oct 20,2024 - Subhamay  - Initial Version
## ---------------------------------------------------------------------------------------------------------------------

# --- root/main.tf ---

# -- VPC, Subnets, Route Tables, NACL, Internet Gateway
module "networking" {
  source            = "./modules/networking"
  aws_region        = var.aws_region
  vpc_cidr          = var.vpc_cidr
  max_subnet_count  = var.max_subnet_count
  public_cidrs      = local.public_cidrs
  project_name      = var.project_name
  environment_name  = var.environment_name
  github_repo       = var.github_repo
  github_url        = var.github_url
  github_ref        = var.github_ref
  github_sha        = var.github_sha
  ci_build          = var.ci_build
}

#-- EC2 Instances

module "compute" {
  source            = "./modules/compute"
  instance_count    = var.instance_count
  subnets           = local.subnets
  security_group_id = module.networking.outputs.security_group_id
  instance_type     = var.instance_type
  vol_size          = var.volume
  project_name      = var.project_name
  environment_name  = var.environment_name
  github_repo       = var.github_repo
  github_url        = var.github_url
  github_ref        = var.github_ref
  github_sha        = var.github_sha
  ci_build          = var.ci_build
}
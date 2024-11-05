## ---------------------------------------------------------------------------------------------------------------------
## Project Name                         - GitOps Minicamp 2024
## Project Description                  - GitOps Minicamp by Derek Morgan and Andrew Brown using GitHub
##                                        Actions and Terraform.
## Modification History:
##   - 1.0.0    Oct 20,2024 - Subhamay  - Initial Version
## ---------------------------------------------------------------------------------------------------------------------

# --- root/locals.tf ---

locals {
  public_cidrs  = [for i in range(0, 255, 2) : cidrsubnet(var.vpc_cidr, 8, i)]
}

locals {
  subnets = [
    {
      cidr_block = module.networking.outputs.subnets.public[0].cidr_block
      subnet_id  = module.networking.outputs.subnets.public[0].subnet_id
      public     = true
  }]
}
## ---------------------------------------------------------------------------------------------------------------------
## Project Name                         - GitOps Minicamp 2024
## Project Description                  - GitOps Minicamp by Derek Morgan and Andrew Brown using GitHub
##                                        Actions and Terraform.
## Modification History:
##   - 1.0.0    Oct 20,2024 - Subhamay  - Initial Version
## ---------------------------------------------------------------------------------------------------------------------

# --- networking/variables.tf ---

variable "vpc_cidr" {
  type        = string
  description = "VPC CIDR range of IP addresses."
}
variable "aws_region" {
  type    = string
  default = "us-east-1"
}
variable "public_cidrs" {
  type        = list(string)
  description = "Range of IP addresses for public subnets."
}
# variable "private_cidrs" {
#   type        = list(string)
#   description = "Range of IP addresses for private subnets."
# }
variable "max_subnet_count" {
  type        = number
  description = "Maximum number of subnets allowed to create"
}
######################################## Project Name ##############################################
variable "project_name" {
  description = "The name of the project"
  type        = string
  default     = "gitops-minicamp-2024"
}
######################################## Environment Name ##########################################
variable "environment_name" {
  type        = string
  description = <<EOT
  (Optional) The environment in which to deploy our resources to.

  Options:
  - devl : Development
  - test: Test
  - prod: Production

  Default: devl
  EOT
  default     = "devl"

  validation {
    condition     = can(regex("^devl$|^test$|^prod$", var.environment_name))
    error_message = "Err: environment is not valid."
  }
}
######################################## GitHub Variables ##########################################
variable "github_repo" {
  type        = string
  description = "GitHub Repository Name"
  default     = ""
}

variable "github_url" {
  type        = string
  description = "GitHub Repository URL"
  default     = ""
}
variable "github_ref" {
  type        = string
  description = "GitHub Ref"
  default     = ""
}
variable "github_sha" {
  type        = string
  description = "GitHub SHA"
  default     = ""
}
variable "ci_build" {
  type        = string
  description = "Ci Build String"
  default     = ""
}
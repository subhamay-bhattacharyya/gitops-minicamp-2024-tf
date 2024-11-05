## ---------------------------------------------------------------------------------------------------------------------
## Project Name                         - GitOps Minicamp 2024
## Project Description                  - GitOps Minicamp by Derek Morgan and Andrew Brown using GitHub
##                                        Actions and Terraform.
## Modification History:
##   - 1.0.0    Oct 20,2024 - Subhamay  - Initial Version
## ---------------------------------------------------------------------------------------------------------------------
# --- compute/variables.tf ---

######################################## EC2 #######################################################
variable "instance_count" {
  type        = string
  description = "Number of EC2 instances to be spinned up."
}
variable "instance_type" {
  type        = string
  description = "EC2 instance type"
}
variable "subnets" {
  description = "Public and private subnets"
}
variable "security_group_id" {
  type        = string
  description = "Security group id of EC2 instance"
}
variable "vol_size" {
  type        = number
  description = "EBS volume size"
}
# variable "instance_profile" {
#   type        = string
#   description = "Instance profile name"
# }
######################################## Project Name ##############################################
variable "project_name" {
  description = "The name of the project"
  type        = string
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
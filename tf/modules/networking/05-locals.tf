## ---------------------------------------------------------------------------------------------------------------------
## Project Name                         - GitOps Minicamp 2024
## Project Description                  - GitOps Minicamp by Derek Morgan and Andrew Brown using GitHub
##                                        Actions and Terraform.
## Modification History:
##   - 1.0.0    Oct 20,2024 - Subhamay  - Initial Version
## ---------------------------------------------------------------------------------------------------------------------

# --- networking/locals.tf ---

locals {
  tags = tomap({
    Environment      = var.environment_name
    ProjectName      = var.project_name
    GitHubRepository = var.github_repo
    GitHubRef        = var.github_ref
    GitHubURL        = var.github_url
    GitHubSHA        = var.github_sha
  })
}
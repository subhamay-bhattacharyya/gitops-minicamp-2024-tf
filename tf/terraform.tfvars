## ---------------------------------------------------------------------------------------------------------------------
## Project Name                         - GitOps Minicamp 2024
## Project Description                  - GitOps Minicamp by Derek Morgan and Andrew Brown using GitHub
##                                        Actions and Terraform.
## Modification History:
##   - 1.0.0    Oct 20,2024 - Subhamay  - Initial Version
## ---------------------------------------------------------------------------------------------------------------------

vpc_cidr         = "10.0.0.0/16"
max_subnet_count = 1
aws_region       = "us-east-1"
instance_count   = 1
volume           = 10
instance_type    = "t2.micro"
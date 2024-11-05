## ---------------------------------------------------------------------------------------------------------------------
## Project Name                         - GitOps Minicamp 2024
## Project Description                  - GitOps Minicamp by Derek Morgan and Andrew Brown using GitHub
##                                        Actions and Terraform.
## Modification History:
##   - 1.0.0    Oct 20,2024 - Subhamay  - Initial Version
## ---------------------------------------------------------------------------------------------------------------------

# --- compute/outputs.tf ---

output "outputs" {
  value = {
    instances = [for i in range(0, var.instance_count) : {
      name           = aws_instance.ec2[i].tags["Name"]
      arn            = aws_instance.ec2[i].arn
      instance_state = aws_instance.ec2[i].arn
      instance_id    = aws_instance.ec2[i].id
      }
    ]
  }
}
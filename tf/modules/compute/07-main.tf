## ---------------------------------------------------------------------------------------------------------------------
## Project Name                         - GitOps Minicamp 2024
## Project Description                  - GitOps Minicamp by Derek Morgan and Andrew Brown using GitHub
##                                        Actions and Terraform.
## Modification History:
##   - 1.0.0    Oct 20,2024 - Subhamay  - Initial Version
## ---------------------------------------------------------------------------------------------------------------------

# --- compute/main.tf ---

resource "random_id" "ec2_id" {
  byte_length = 2
  count       = var.instance_count
}

resource "aws_instance" "ec2" {
  count                       = var.instance_count
  instance_type               = var.instance_type
  ami                         = data.aws_ami.ami.id
  vpc_security_group_ids      = [var.security_group_id]
  subnet_id                   = var.subnets[count.index].subnet_id
  associate_public_ip_address = var.subnets[count.index].public
  # iam_instance_profile        = var.instance_profile
  # private_ip                  = join(".", concat(slice(split(".", split("/", var.subnets[count.index].cidr_block)[0]), 0, 3), [100]))
  user_data = file(join("/", [path.module, "userdata.tftpl"]))
  root_block_device {
    volume_size = var.vol_size # 10
  }

  tags = merge({
    Name = "${var.project_name}-${var.environment_name}-ec2-${count.index}${var.ci_build}"
  }, local.tags)
}
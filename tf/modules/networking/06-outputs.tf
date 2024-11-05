## ---------------------------------------------------------------------------------------------------------------------
## Project Name                         - GitOps Minicamp 2024
## Project Description                  - GitOps Minicamp by Derek Morgan and Andrew Brown using GitHub
##                                        Actions and Terraform.
## Modification History:
##   - 1.0.0    Oct 20,2024 - Subhamay  - Initial Version
## ---------------------------------------------------------------------------------------------------------------------

# --- networking/outputs.tf ---

output "outputs" {
  value = { vpc = {
    name                   = aws_vpc.vpc.tags["Name"]
    vpc_id                 = aws_vpc.vpc.id
    cidr_block             = aws_vpc.vpc.cidr_block
    dhcp_options_id        = aws_vpc.vpc.dhcp_options_id
    main_route_table_id    = aws_vpc.vpc.main_route_table_id
    default_network_acl_id = aws_vpc.vpc.default_network_acl_id
    instance_tenancy       = aws_vpc.vpc.instance_tenancy
    owner_id               = aws_vpc.vpc.owner_id
    },
    igw = {
      name   = aws_internet_gateway.igw.tags["Name"]
      igw_id = aws_internet_gateway.igw.id
      arn    = aws_internet_gateway.igw.arn
    }
    subnets = {
      public = [for i in range(0, length(aws_subnet.public_subnet)) : {
        name       = aws_subnet.public_subnet[i].tags["Name"]
        subnet_id  = aws_subnet.public_subnet[i].id
        cidr_block = aws_subnet.public_subnet[i].cidr_block
        arn = aws_subnet.public_subnet[i].arn }
      ]
    },
    route_table : {
      route_table : {
        name : aws_route_table.route_table.tags["Name"]
        route_table_id : aws_route_table_association.route_table_association[0].route_table_id
        association_id : aws_route_table_association.route_table_association.*.id
        subnet_association : aws_route_table_association.route_table_association.*.subnet_id
      }
    }
    security_group_id = aws_security_group.security_group.id
  }
}

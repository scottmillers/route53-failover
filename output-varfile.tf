# Output a file with variable for testing scripts

# Output a set of variables used by your scripts
resource "local_file" "output_variables" {
  content  = local.variables
  filename = "${path.module}/scripts/variables.zsh"
}

locals {
  variables = <<-EOT
    #!/bin/zsh
    ##
    ## variables for the ZSH shell scripts
    ##
    
    INSTANCE_ID=${module.ec2_us_east_2.instance_id}
    
    REGION=${module.ec2_us_east_2.instance_region}

  EOT

}


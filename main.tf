/*
    This terraform will
    Create 2 EC2 instances with web servers in two different regions
    Register their public IP addresses on Route53 using different routing policies

*/
# Define the AWS provider with aliases for each region
provider "aws" {
  alias  = "us_east_2"
  region = "us-east-2"
}

provider "aws" {
  alias  = "us_west_2"
  region = "us-west-2"
}


# Create a EC2 in us-east-2
module "ec2_us_east_2" {
  providers = {
    aws.alternative = aws.us_east_2
  }
  source = "./modules/ec2"
}


# Create a EC2 in us-west-2
module "ec2_us_west_2" {
  providers = {
    aws.alternative = aws.us_west_2
  }
  source = "./modules/ec2"
}


# Get the existing Route53 hosted zone
data "aws_route53_zone" "selected" {
  name         = var.hostedzone_name
  private_zone = false
}

# Example of a Failover(Disaster recovery) across two Regions

# Record for the primary domain
resource "aws_route53_record" "us_east_2" {
  zone_id = data.aws_route53_zone.selected.zone_id
  name    = "failover"
  type    = "A"
  ttl     = 60
  failover_routing_policy {
    type = "PRIMARY"
  }
  set_identifier  = "useast2"
  records         = [module.ec2_us_east_2.public_ip]
  health_check_id = aws_route53_health_check.us_east_2.id
}


# Health check for the primary domain
resource "aws_route53_health_check" "us_east_2" {
  ip_address        = module.ec2_us_east_2.public_ip
  port              = 80
  type              = "HTTP"
  resource_path     = "/"
  failure_threshold = 5
  request_interval  = 30
}


# Record for the secondary domain
resource "aws_route53_record" "us_west_2" {
  zone_id = data.aws_route53_zone.selected.zone_id
  name    = "failover"
  type    = "A"
  ttl     = 60
  failover_routing_policy {
    type = "SECONDARY"
  }

  set_identifier  = "uswest2"
  records         = [module.ec2_us_west_2.public_ip]
  health_check_id = aws_route53_health_check.us_west_2.id
}


# Health check for the secondary domain
resource "aws_route53_health_check" "us_west_2" {
  ip_address        = module.ec2_us_west_2.public_ip
  port              = 80
  type              = "HTTP"
  resource_path     = "/"
  failure_threshold = 3
  request_interval  = 30
}




# Example of a Simple Record for us-east-2 web server
/*resource "aws_route53_record" "simple" {
  zone_id = data.aws_route53_zone.selected.zone_id
  name    = "simple.${data.aws_route53_zone.selected.name}"
  type    = "A"
  ttl     = 300
  records = [module.ec2_us_east_2.public_ip]
}
*/


# Example of a Weighted Records across two Regions
/*
resource "aws_route53_record" "weighted_us_east_2" {
  zone_id = data.aws_route53_zone.selected.zone_id
  name    = "weighted"
  type    = "A"
  ttl     = 3
  weighted_routing_policy {
    weight = 70    
  }
  set_identifier = "useast2"
  
  records = [module.ec2_us_east_2.public_ip]
}

resource "aws_route53_record" "weighted_us_west_2" {
  zone_id = data.aws_route53_zone.selected.zone_id
  name    = "weighted"
  type    = "A"
  ttl     = 3
  weighted_routing_policy {
    weight = 30    
  }
  set_identifier = "uswest2"
  
  records = [module.ec2_us_west_2.public_ip]
}
*/









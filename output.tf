
output "us_east_2_default_vpc_id" {
  value = module.ec2_us_east_2.vpc_id
}

output "us_east_2_default_subnet_id" {
  value = module.ec2_us_east_2.subnet_id
}

output "us_east_2_public_ip" {
  value = module.ec2_us_east_2.public_ip
}

output "us_west_2_default_vpc_id" {
  value = module.ec2_us_west_2.vpc_id
}

output "us_west_2_default_subnet_id" {
  value = module.ec2_us_west_2.subnet_id
}

output "us_west_2_public_ip" {
  value = module.ec2_us_west_2.public_ip
}


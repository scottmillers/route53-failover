output "vpc_id" {
  description = "EC2 VPC"
  value = data.aws_vpc.default.id
}

output "subnet_id" {
  description = "EC2 subnet"
  value = data.aws_subnets.subnets.ids[0]
}

output "public_ip" {
  description = "EC2 public ip"
  value = aws_eip.websrv_eip.public_ip
}

output "instance_id" {
  description = "EC2 instance id"
  value = aws_instance.websrv_one.id
}

output "instance_region" {
  description = "EC2 instance region"
  value = data.aws_region.current.name
}

output "ec2_public_ips" {
  description = "Public IPs of EC2 instances"

  value = {
    for name, instance in aws_instance.ec2 :
    name => instance.public_ip
  }
}
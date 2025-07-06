output "instance_id" {
  description = "EC2インスタンスID"
  value       = aws_instance.web.id
}

output "instance_public_ip" {
  description = "EC2インスタンスのパブリックIPアドレス"
  value       = aws_instance.web.public_ip
}

output "instance_public_dns" {
  description = "EC2インスタンスのパブリックDNS名"
  value       = aws_instance.web.public_dns
}

output "security_group_id" {
  description = "セキュリティグループID"
  value       = aws_security_group.web.id
}
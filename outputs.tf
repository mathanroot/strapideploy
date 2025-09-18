output "web" {
  value       = aws_instance.web.public_ip
  
}

output "web1" {
  value       = aws_instance.web.private_ip
  
}

output "db" {
  value       = aws_instance.db.private_ip
  
}


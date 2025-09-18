output "web" {
  value       = aws_instance.web.public_ip
  
}

output "web1" {
  value       = aws_instance.web.private_ip
  
}

output "db" {
  value       = aws_instance.db.private_ip
  
}

output "strapi_admin_url" {
  description = "Admin Panel URL for Strapi"
  value       = "http://${aws_instance.web.public_ip}:1337/admin"
}



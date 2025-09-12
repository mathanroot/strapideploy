output "ec2_public_ip" {
  value = aws_instance.strapi_ec2.public_ip
}

output "rds_endpoint" {
  value = aws_db_instance.strapi_db.endpoint
}

output "s3_bucket" {
  value = aws_s3_bucket.strapi_media.bucket
}

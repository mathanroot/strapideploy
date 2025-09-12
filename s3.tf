resource "aws_s3_bucket" "strapi_media" {
  bucket = "strapi-media-bucket-${random_id.bucket_suffix.hex}"
  acl    = "private"
}

resource "random_id" "bucket_suffix" {
  byte_length = 4
}

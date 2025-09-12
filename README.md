# strapideploy

In this project deployed by AWS Services EC2,S3,RDS,VPC,ROUTE53 .

EC2 FOR DEPLOY APPLICATION

S3 FOR STORE DATAS

RDS FOR CREATE A DATABASE FROM THE STRAPI

VPC FOR COMMUNUCATION BETWEEN EC2 AND RDS

ROUTE53 FOR DOMAIN NAME SYSTEM FOR ACCESS HTTPS

[MUST] AND I HAVE CREATED A IAM ROLE WITH GUI FOR THE TERRAFORM ACCESS FROM AWS RESOURCES .

# Project Structure:

```bash
strapi-terraform/
├── README.md                # Documentation for your repo
├── main.tf                  # Root file that just includes modules or loads other .tf files
├── variables.tf             # All variables with descriptions and defaults
├── outputs.tf               # All outputs (EC2 IP, RDS endpoint, S3 bucket name, etc.)
├── vpc.tf                   # VPC, subnets, IGW, route tables, associations
├── security.tf              # Security groups for EC2 & RDS
├── ec2.tf                   # EC2 instance, user-data
├── rds.tf                   # RDS instance & subnet group
├── s3.tf                    # S3 bucket for Strapi media
├── route53.tf               # (Optional) Route53 hosted zone & record
```



  






STEPS:

Clone from the Repo,
```bash
git clone https://github.com/mathanroot/strapideploy.git

cd strapideploy
```

```bash
terraform init

terraform plan

terraform apply
```

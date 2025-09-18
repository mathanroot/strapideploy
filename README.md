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
├── main.tf                  # Root file that just includes modules or loads other .tf files included vpc,igw,subnets,routetable,security groupand ec2 and db configuration and installing strapi
├── outputs.tf               # All outputs (EC2 IP, RDS endpoint, S3 bucket name, etc.)
├── rds.tf                   # RDS instance & subnet group
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


After Deploying AWS SERVICES then i have run on ec2 server for STRAPI CMS access

After,
<img width="1920" height="1200" alt="image" src="https://github.com/user-attachments/assets/25d237c2-4e39-4eed-af6c-30c968b761b9" />


ref if any info https://strapi.io/integrations/aws

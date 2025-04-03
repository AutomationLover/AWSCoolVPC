# AWSCoolVPC
It is a terraform repo, which created VPC in AWS as a demo. 
In this demo, this VPC create a number of subnet for clusters nodes and control plans. And related IGW, NATGW, and route table.

Cli to deploy this AWSCoolVPC to your AWS account as dev env in us-east-1 region:

```
cd platform/aws
terraform init
terraform plan -var-file=../../tfvars/common/dev.tfvars -var-file=../../tfvars/dev/us-east-1/variables.tfvars"
terraform apply -var-file=../../tfvars/common/dev.tfvars -var-file=../../tfvars/dev/us-east-1/variables.tfvars"
```
# Creating Nginx webserver in AWS in two instances with ALB

## Note:
# terraform/nginx_alb Folder container code without EIP (Elastic IP)
# terraform/nginx_alb_eip Folder container code with EIP (Elastic IP)

## Pre requesites:

1. AWS cli connection has been established
  To establish AWS cli connection and configuring the access
  Ref: https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html

2. Installation of Terraform
  Ref: https://developer.hashicorp.com/terraform/downloads

## Terroform code details:
**provide.tf**
    Provider block is used to do Installation of provider (aws, azure, gcp) to perform the terraform execution as per the cloud environemt
  
**variable.tf**
    This file containes globally defined details to achieve the requirements, below listed are defined varibles.
    VPC Details *(Change as per your requirement, here used default CIDR)*
    Instance Type Details *(Change as per your requirement, here used free tier)*
    Image ID Details *(Change as per your requirement, here used Ubuntu Image ID)*
    Keypair Details *(Download your keypair into code folder and change the name of your keypair in variable.tf file)*
 
**data.tf**
    To fetch the available zones as per the requested region
 
**vpc.tf**
    This file defines how to create the VPC, Subnet and Route Table as given in variable.tf and the zones has been created
  as per the available zones by referring data.tf.
  
**secgroup.tf**
    This file used to define what are all the ports need to be allowed instance and ALB level.
  
**ec2.tf**
    This file containes ec2 instance creation for the ALB as per image ID given in variable.tf
  
**alb.tf**
    This file containes ALB and Target group creation and association of the instance for the ALB.
  
**nginx.sh**
  This file used to execute the installation of nginx using shell script.
  *Note: command diff based on the distribuation here i used Ubuntu.*
  
**output.tf**
    This file help to display the below details:
    Public DNS (ALB URL)
    Private DNS (Instance URL)
    Public IP
    Private IP

Installation Procedure:
  Clone the git repo in local machine
  
  git clone https://github.com/nirmalk1004/terraform.git
  
  Change into the folder nginx_alb or nginx_alb_eip
  
  Download and move the aws keypair into the respective folder nginx_alb or nginx_alb_eip
  
  Need to change the variable.tf file as per your requirment and environemnt
  
  terraform executions:
  
    To download provider details
    
    $terraform init
    
    To know the execution going to perform in aws
    
    $terraform plan
    
    To perform or implement the execution as per the plan in aws
    
    $terraform apply
    
    To clear or undo the installation from the aws
    
    $terraform destroy
    
    
    
    
  
  
  
  
  


 
 
  
  





Creating Nginx web server in AWS with two instances and ALB
Note:
The terraform/nginx_alb folder contains the code without Elastic IP (EIP).
The terraform/nginx_alb_eip folder contains the code with Elastic IP (EIP).
Prerequisites:
Establish AWS CLI connection:

To establish an AWS CLI connection and configure access, refer to: AWS CLI User Guide.
Install Terraform:

To install Terraform, refer to: Terraform Downloads.
Terraform code details:
provide.tf

The provider block is used to install and configure the necessary provider (AWS, Azure, GCP) for executing Terraform commands in the desired cloud environment.
variable.tf

This file contains globally defined variables required to meet the project requirements. The following variables are defined:
VPC Details (Change as per your requirement; default CIDR is used here)
Instance Type Details (Change as per your requirement; free tier is used here)
Image ID Details (Change as per your requirement; Ubuntu Image ID is used here)
Keypair Details (Download your keypair into the code folder and update the keypair name in variable.tf file)
data.tf

This file fetches the available zones based on the requested region.
vpc.tf

This file defines the creation of VPC, Subnet, and Route Table using the details provided in variable.tf. The zones are created based on the available zones obtained from data.tf.
secgroup.tf

This file defines the ports to be allowed at the instance and ALB level.
ec2.tf

This file contains the code for creating EC2 instances for the ALB using the image ID provided in variable.tf.
alb.tf

This file contains the code for creating the ALB and Target Group and associating the instances with the ALB.
nginx.sh

This shell script file is used to install Nginx. The command may vary based on the distribution; here, Ubuntu is used.
output.tf

This file displays the following details:
Public DNS (ALB URL)
Private DNS (Instance URL)
Public IP
Private IP
Installation Procedure:

Clone the Git repository to your local machine:

bash
Copy code
git clone https://github.com/nirmalk1004/terraform.git
Change to the nginx_alb or nginx_alb_eip folder, depending on your requirement.

Download and move the AWS keypair into the respective folder (nginx_alb or nginx_alb_eip).

Modify the variable.tf file according to your requirements and environment.

Execute the following Terraform commands:

To download provider details:
terraform init

To view the execution plan:
terraform plan

To create the infrastructure in AWS:
terraform apply

To remove the infrastructure from AWS:
terraform destroy

# Creating Nginx Web Server in AWS with Two Instances and ALB using Terraform

## Note
- The `terraform/nginx_alb` folder contains the code without Elastic IP (EIP).
- The `terraform/nginx_alb_eip` folder contains the code with Elastic IP (EIP).

## Prerequisites
1. Establish AWS CLI Connection
   - Follow the instructions in the [AWS CLI User Guide](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) to establish an AWS CLI connection and configure access.

2. Install Terraform
   - Download and install Terraform from the [Terraform Downloads](https://developer.hashicorp.com/terraform/downloads) page.

## Terraform Code Details

### provide.tf
- The `provide.tf` file installs and configures the necessary provider (AWS, Azure, GCP) for executing Terraform commands in the desired cloud environment.

### variable.tf
- The `variable.tf` file contains globally defined variables required to meet the project requirements. Update the following variables as per your environment:
  - VPC Details (Modify CIDR based on your requirements; default CIDR is used)
  - Instance Type Details (Choose the appropriate instance type; free tier is used here)
  - Image ID Details (Select the desired image ID; Ubuntu Image ID is used here)
  - Keypair Details (Download your keypair and update the keypair name in the file)

### data.tf
- The `data.tf` file fetches the available zones based on the requested region.

### vpc.tf
- The `vpc.tf` file creates the VPC, Subnet, and Route Table using the details provided in `variable.tf`. The zones are created based on the available zones obtained from `data.tf`.

### secgroup.tf
- The `secgroup.tf` file defines the ports that need to be allowed at the instance and ALB level.

### ec2.tf
- The `ec2.tf` file creates the EC2 instances for the ALB using the image ID provided in `variable.tf`.

### alb.tf
- The `alb.tf` file creates the ALB and Target Group and associates the instances with the ALB.

### nginx.sh
- The `nginx.sh` script installs Nginx on the instances. Modify the command based on the distribution you are using (Ubuntu is used here).

### output.tf
- The `output.tf` file displays the following details upon successful execution:
  - Public DNS (ALB URL)
  - Private DNS (Instance URL)
  - Public IP
  - Private IP

## Installation Procedure
1. Clone this Git repository to your local machine:
```
git clone https://github.com/nirmalk1004/terraform.git
```
2. Change the working directory to the `nginx_alb` or `nginx_alb_eip` folder, depending on your requirement.

3. Download your AWS keypair and move it into the respective folder (`nginx_alb` or `nginx_alb_eip`).

4. Modify the `variable.tf` file according to your requirements and environment.

5. Execute the following Terraform commands in order:

- Initialize Terraform:
  ```
  terraform init
  ```
- View the execution plan:
  ```
  terraform plan
  ```
- Create the infrastructure in AWS:
  ```
  terraform apply
  ```
- Remove the infrastructure from AWS:
  ```
  terraform destroy
  ```

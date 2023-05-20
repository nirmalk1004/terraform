
variable "alb_vpc" {
  description = "vpc for nginx alb"
  type        = string
  default     = "10.0.0.0/16"
}

variable "alb_instance" {
  description = "alb instance"
  type        = string
  default     = "default"
}

variable "ami_id" {
  description = "ami id"
  type        = string
  default     = "ami-007855ac798b5175e"
}

variable "instance_type" {
  description = "Instance type to create an instance"
  type        = string
  default     = "t2.micro"
}

variable "ssh_private_key" {
  description = "ssh key"
  type        = string
  default     = "./keypair.pem"
}
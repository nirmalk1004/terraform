resource "aws_instance" "instance" {
  count                = length(aws_subnet.public_subnet.*.id)
  ami                  = var.ami_id
  instance_type        = var.instance_type
  subnet_id            = element(aws_subnet.public_subnet.*.id, count.index)
  associate_public_ip_address = "true"
  security_groups      = [aws_security_group.sg.id, ]

  key_name             = "keypair"

  tags = {
    "Name"        = "nginxmachine-${count.index}"
    "Environment" = "Test"
    "CreatedBy"   = "Terraform"
  }

  timeouts {
    create = "10m"
  }

}

resource "null_resource" "null" {
  count = length(aws_subnet.public_subnet.*.id)

  provisioner "file" {
    source      = "./nginx.sh"
    destination = "/home/ubuntu/nginx.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /home/ubuntu/nginx.sh",
      "sh /home/ubuntu/nginx.sh",
    ]
    on_failure = continue
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"
    port        = "22"
    host        = element(aws_instance.instance.*.public_ip, count.index)
    private_key = file(var.ssh_private_key)
  }

}


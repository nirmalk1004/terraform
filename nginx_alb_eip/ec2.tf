resource "aws_instance" "instance" {
  count                = length(aws_subnet.public_subnet.*.id)
  ami                  = var.ami_id
  instance_type        = var.instance_type
  subnet_id            = element(aws_subnet.public_subnet.*.id, count.index)
  security_groups      = [aws_security_group.sg.id, ]
  key_name             = "keypair"

  tags = {
    "Name"        = "nginx-${count.index}"
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
    host        = element(aws_eip.eip.*.public_ip, count.index)
    private_key = file(var.ssh_private_key)
  }

}

resource "aws_eip" "eip" {
  count            = length(aws_instance.instance.*.id)
  instance         = element(aws_instance.instance.*.id, count.index)
  public_ipv4_pool = "amazon"
  vpc              = true

  tags = {
    "Name" = "EIP-${count.index}"
  }
}
resource "aws_eip_association" "eip_association" {
  count         = length(aws_eip.eip)
  instance_id   = element(aws_instance.instance.*.id, count.index)
  allocation_id = element(aws_eip.eip.*.id, count.index)
}

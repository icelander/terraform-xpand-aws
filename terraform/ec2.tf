resource "aws_instance" "jumpbox" {
  ami = "ami-08882eba49067074f" # Rocky Linux 8
  instance_type = "${var.jump_instance_type}"
  key_name = var.aws_key_name

  security_groups = ["${aws_security_group.ssh-security-group.id}"]
  subnet_id = "${aws_subnet.public-subnet-1.id}"
  associate_public_ip_address = true

  connection {
    type = "ssh"
    host = self.public_ip
    user = "rocky"
    private_key = file(var.ssh_key_path)
    timeout = "4m"
  }

  provisioner "file" {
    source = "${var.ssh_key_path}"
    destination = "/home/rocky/.ssh/id_rsa"
  }

  provisioner "remote-exec" {
    inline = ["chmod 400 /home/rocky/.ssh/id_rsa"]
  }

  lifecycle {
    create_before_destroy = true
  }
  
  tags = {
    "Name" = "xpand-jump"
  }
}

resource "aws_instance" "xpand_db" {
  count = var.db_instance_count
  ami = "ami-05a36e1502605b4aa" # CentOS 7
  instance_type = "${var.db_instance_type}"
  key_name = var.aws_key_name
  security_groups = ["${aws_security_group.ssh-security-group.id}"]
  subnet_id = "${aws_subnet.public-subnet-1.id}"
  associate_public_ip_address = true

  root_block_device {
    volume_type = "gp2"
    volume_size = 100
    delete_on_termination = true
  }
  
  ebs_block_device {
    device_name = "/dev/xvdb"
    volume_size = 100
    volume_type = "io2"
    iops = 5000
    delete_on_termination = true
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    "Name" = "xpand-${count.index + 1}"
  }
}

resource "aws_instance" "maxscale" {
  count = var.maxscale_instance_count
  ami = "ami-05a36e1502605b4aa" # CentOS 7
  instance_type = "${var.maxscale_instance_type}"
  key_name = var.aws_key_name
  security_groups = ["${aws_security_group.ssh-security-group.id}"]
  subnet_id = "${aws_subnet.public-subnet-1.id}"
  associate_public_ip_address = true

  tags = {
    "Name" = "xpand-maxscale-${count.index + 1}"
  }
}
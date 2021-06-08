  locals {
  common_tags = {
    Purpose = "Education"
    Project = "Lesson 2"
    Class   = "Modules"
  }
}

  resource "aws_instance" "UbuntuServer" {
    count = var.instance_count
    ami = var.ami_id
    instance_type = var.instance_type
    subnet_id = var.subnet_id
    security_groups = [aws_security_group.StagingUbuntuServer.id]
    tags = local.common_tags
    key_name = aws_key_pair.deployer.key_name

  }

  resource "aws_key_pair" "deployer" {
    key_name   = "deployer-key"
    public_key = var.aws_key_pair
  }

  resource "aws_ebs_volume" "root_volume" {
  availability_zone = var.availability_zone
  size              = var.volume_size

  tags = {
    Name = "LinuxRootVolume"
  }
}

  resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.root_volume.id
  instance_id = aws_instance.UbuntuServer[0].id
}

  resource "aws_network_interface" "UbuntuServerNetworkInterface" {
  subnet_id = var.subnet_id
}

  resource "aws_security_group" "StagingUbuntuServer" {
  name_prefix = "For staging env"
  description = "Hillel Modules"
  vpc_id = var.vpc_id
  tags = local.common_tags
  egress { // allow outgoing traffic to anywhere
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

  resource "aws_security_group_rule" "SSH" {
    description       = "Allow SSH from the world, not secure"
    type              = "ingress"
    from_port         = 22
    to_port           = 22
    protocol          = "tcp"
    cidr_blocks       = ["0.0.0.0/0"]
    security_group_id = aws_security_group.StagingUbuntuServer.id
  }

  resource "aws_security_group_rule" "Tomcat" {
  description       = "Allow SSH from the world, not secure"
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.StagingUbuntuServer.id
}

  resource "aws_eip" "UbuntuServer" {
      count    = (var.eip_attach ? 1 : 0)
      instance = aws_instance.UbuntuServer[count.index].id
      tags     = local.common_tags
  }

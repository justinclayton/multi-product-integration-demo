# data "aws_availability_zones" "available" {
#   filter {
#     name   = "zone-type"
#     values = ["availability-zone"]
#   }
# }

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]  # Canonical owner ID for official Ubuntu AMIs

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}

# Create a security group that allows inbound traffic from the vpc on port 5432
resource "aws_security_group" "database" {
  name        = "database"
  description = "database"
  vpc_id      = local.ddr_vpc_id

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_vpc_security_group_ingress_rule" "database_ingress_rule" {
  security_group_id = aws_security_group.database.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
  from_port         = 0
  to_port           = 0
  # from_port         = 5432
  # to_port           = 5432
}

resource "aws_vpc_security_group_egress_rule" "database_egress_rule" {
  security_group_id = aws_security_group.database.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

resource "random_shuffle" "az" {
  input        = data.aws_availability_zones.available.names
  result_count = 1
}

# Create an EC2 instance running PostgreSQL
resource "aws_instance" "database" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "m5.large"
  subnet_id     = random_shuffle.az.result[0]
  # key_name      = "my_key_pair"  # Replace with the name of your key pair

  vpc_security_group_ids = [aws_security_group.database.id]

  user_data = <<-EOF
    #!/bin/bash
    sudo apt-get update
    sudo apt-get install -y postgresql
    sudo systemctl enable postgresql
    sudo systemctl start postgresql
    # probably more setup here...
  EOF
}

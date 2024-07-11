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
  # from_port         = 5432
  # to_port           = 5432
}

resource "aws_vpc_security_group_egress_rule" "database_egress_rule" {
  security_group_id = aws_security_group.database.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

resource "random_shuffle" "subnets" {
  input        = local.ddr_subnet_ids
  result_count = 1
}

# Create an EC2 instance running PostgreSQL
resource "aws_instance" "database" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "m5.large"
  subnet_id     = random_shuffle.subnets.result[0]
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

resource "aws_db_subnet_group" "db" {
  name = "db_subnet_group"
  subnet_ids = local.ddr_subnet_ids
}

resource "aws_rds_cluster" "db" {
  cluster_identifier   = "aurora-cluster-demo"
  availability_zones   = ["us-west-2a", "us-west-2b", "us-west-2c"]
  database_name        = "mydb"
  master_username      = "foo"
  master_password      = "barbut8chars"
  engine               = "aurora-postgresql"
  db_subnet_group_name = aws_db_subnet_group.db.name
  skip_final_snapshot  = true
  vpc_security_group_ids = [ aws_security_group.database.id ]
}


resource "aws_rds_cluster_instance" "db" {
  count              = 2
  identifier         = "aurora-cluster-demo-${count.index}"
  cluster_identifier = aws_rds_cluster.db.id
  instance_class     = "db.r5.large"
  engine             = aws_rds_cluster.db.engine
  engine_version     = aws_rds_cluster.db.engine_version
  db_subnet_group_name = aws_rds_cluster.db.db_subnet_group_name
}

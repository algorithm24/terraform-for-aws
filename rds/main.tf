resource "aws_db_parameter_group" "mariadb-parameters" {
  name = "${var.env}-mariadb-parameters"
  family = "mariadb10.5"
  description = "MariaDB parameter group"
  
  parameter {
    name = "max_allowed_packet"
    value = "16777216"
  }
}

resource "aws_db_subnet_group" "mariadb-subnet" {
  name = "${var.env}-mariadb-subnet"
  description = "RDS subnet group"
  subnet_ids = var.subnet_ids
}

resource "aws_db_instance" "mariadb" {
  allocated_storage = 10
  engine = "mariadb"
  engine_version = "10.5"
  instance_class = "db.t2.medium"
  identifier = "${var.env}-mariadb"
  db_name = "${var.env}mariadb"
  username = var.username
  password = var.password
  db_subnet_group_name = aws_db_subnet_group.mariadb-subnet.name
  parameter_group_name = "${var.env}-mariadb-parameters"
  multi_az = "true"
  vpc_security_group_ids = [aws_security_group.allow-mariadb.id]
  storage_type = "gp2"
  backup_retention_period = 30
  skip_final_snapshot = true
  tags = {
    Name = "${var.env}-mariadb-instance"
  }
}
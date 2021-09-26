resource "aws_default_vpc" "main" {
  tags = {
    Name = "default VPC"
  }
}

resource "aws_security_group" "db" {
  name        = "db"
  description = "allow db traffic"
  vpc_id      = aws_default_vpc.main.id

  ingress {
    from_port   = 5432
    protocol    = "TCP"
    to_port     = 5432
    cidr_blocks = [
      "0.0.0.0/0"]
  }

  egress {
    from_port   = 5432
    protocol    = "TCP"
    to_port     = 5432
    cidr_blocks = [
      "0.0.0.0/0"]
  }
}

resource "aws_db_instance" "hasura-db" {
  allocated_storage      = 20
  instance_class         = "db.t2.micro"
  name                   = "hasura"
  identifier             = "hasura-db"
  engine                 = "postgres"
  engine_version         = "12.7"
  password               = random_password.database_password.result
  username               = "postgres"
  publicly_accessible    = true
  vpc_security_group_ids = [
    aws_security_group.db.id]
}

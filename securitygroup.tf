
resource "aws_security_group" "default" {
  vpc_id = aws_vpc.initial_vpc.id

  ingress {
    protocol  = -1
    self      = true
    from_port = 0
    to_port   = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "web_sg" {
  vpc_id = aws_vpc.initial_vpc.id

  ingress {
    protocol  = "tcp"
    self      = true
    from_port = 80
    to_port   = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "db_sg" {
  name_prefix = "db-"
  vpc_id      = aws_vpc.initial_vpc.id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.initial_vpc.cidr_block]
  }

  tags = {
    Name = "db-security-group"
  }
}


resource "aws_security_group" "lb_sg" {
  name        = "lb_sg-${terraform.workspace}"
  description = "controls access to the LB"
  vpc_id      = aws_vpc.initial_vpc.id
  tags = merge(
    {
      "Name" : "lb_sg-${terraform.workspace}"
    }, 
  )
}


resource "aws_security_group_rule" "web_to_lb" {
  security_group_id = aws_security_group.lb_sg.id
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]

}

resource "aws_security_group_rule" "web_to_lb_secure" {
  security_group_id = aws_security_group.lb_sg.id
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]

}

resource "aws_security_group_rule" "lb_egress" {
  security_group_id = aws_security_group.lb_sg.id
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}





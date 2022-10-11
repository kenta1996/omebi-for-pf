# web用セキュリティグループ
resource "aws_security_group" "web" {
  name   = "pf-web"
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "pf-web"
  }
}

resource "aws_security_group_rule" "ingress_web1" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.web.id
}

resource "aws_security_group_rule" "ingress_web2" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.web.id
}

resource "aws_security_group_rule" "ingress_web3" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = aws_security_group.web.id
}

resource "aws_security_group_rule" "ingress_web4" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = aws_security_group.web.id
}

resource "aws_security_group_rule" "ingress_web5" {
    type        = "ingress"
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks  = ["0.0.0.0/0"]
    security_group_id = aws_security_group.web.id
}

resource "aws_security_group_rule" "egress_web" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.web.id
}


# DB用セキュリティグループ
resource "aws_security_group" "db" {
  name   = "pf-db"
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "pf-db"
  }
}

# source_security_group_idを使ってwebのセキュリティグループを指定
resource "aws_security_group_rule" "ingress_db" {
  description = "MySQL"
  type              = "ingress"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  source_security_group_id = aws_security_group.web.id
  security_group_id = aws_security_group.db.id
}

resource "aws_security_group_rule" "egress_db" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.db.id
}
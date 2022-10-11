# Subnet
resource "aws_subnet" "public_1a" {
  # 先程作成したVPCを参照し、そのVPC内にSubnetを立てる
  vpc_id = "${aws_vpc.main.id}"
  availability_zone = "ap-northeast-1a"
  cidr_block        = "172.31.0.0/20"
  tags = {
    Name = "pf-public-1a"
  }
}

resource "aws_subnet" "public_1c" {
  vpc_id = "${aws_vpc.main.id}"
  availability_zone = "ap-northeast-1c"
  cidr_block        = "172.31.16.0/20"
  tags = {
    Name = "pf-public-1c"
  }
}

# Private Subnets
resource "aws_subnet" "private_1a" {
  vpc_id = "${aws_vpc.main.id}"

  availability_zone = "ap-northeast-1a"
  cidr_block        = "172.31.48.0/20"

  tags = {
    Name = "pf-private-1a"
  }
}

resource "aws_subnet" "private_1c" {
  vpc_id = "${aws_vpc.main.id}"

  availability_zone = "ap-northeast-1c"
  cidr_block        = "172.31.64.0/20"

  tags = {
    Name = "pf-private-1c"
  }
}
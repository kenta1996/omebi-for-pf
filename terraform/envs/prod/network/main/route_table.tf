# public
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "${aws_vpc.this.tags.Name}-public"
  }
}

# ルートテーブルの「ルート」の設定
resource "aws_route" "internet_gateway_public" {
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this.id
  route_table_id         = aws_route_table.public.id
}

# ルートテーブルの「サブネットの関連付け」の設定
resource "aws_route_table_association" "public" {
  for_each = var.azs

  route_table_id = aws_route_table.public.id
  subnet_id      = aws_subnet.public[each.key].id
}

# private
resource "aws_route_table" "private" {
  # for_each = var.azs
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "${aws_vpc.this.tags.Name}-private"
  }
  # tags = {
  #   Name = "${aws_vpc.this.tags.Name}-private-${each.key}"
  # }
}


# ルートの設定はいらない
# resource "aws_route" "nat_gateway_private" {
#   for_each = var.enable_nat_gateway ? var.azs : {}

#   destination_cidr_block = "0.0.0.0/0"
#   nat_gateway_id         = aws_nat_gateway.this[var.single_nat_gateway ? keys(var.azs)[0] : each.key].id
#   route_table_id         = aws_route_table.private[each.key].id
# }


# ルートテーブルを2つ作ってる→1つに変えた
resource "aws_route_table_association" "private" {
  for_each = var.azs

  route_table_id = aws_route_table.private.id
  subnet_id      = aws_subnet.private[each.key].id
}
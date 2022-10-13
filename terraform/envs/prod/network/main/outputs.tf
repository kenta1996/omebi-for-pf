# サブネットとセキュリティグループを別ディレクトリで使用させるため
output "security_group_web_id" {
  value = aws_security_group.web.id
}

output "security_group_db_omobi_id" {
  value = aws_security_group.db_omobi.id
}

output "subnet_public" {
  value = aws_subnet.public
}

output "subnet_private" {
  value = aws_subnet.private
}

output "vpc_this_id" {
  value = aws_vpc.this.id
}

output "db_subnet_group_this_id" {
  value = aws_db_subnet_group.this.id
}
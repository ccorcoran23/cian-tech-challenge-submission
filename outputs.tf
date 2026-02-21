data "aws_caller_identity" "current" {}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}

output "aws_instance_public" {
  value = aws_instance.public.id
}

output "aws_instance_private" {
  value = aws_instance.private.id
}

output "aws_nat_gateway" {
  value = aws_nat_gateway.main.id
}
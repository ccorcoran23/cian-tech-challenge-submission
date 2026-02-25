data "aws_ami" "debian12" {
  most_recent = true
  owners      = ["136693071363"]

  filter {
    name   = "name"
    values = ["debian-12-amd64-*"]
  }
}

resource "aws_key_pair" "main" {
  key_name   = "admin-key"
  public_key = file(var.ssh_public_key_path)
  tags = {
    Terraform = "true"
    Name = "User-local-key-for-ssh"
  }
}

resource "aws_instance" "public" {
  ami                         = data.aws_ami.debian12.id
  key_name                    = aws_key_pair.main.key_name
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.public.id
  vpc_security_group_ids      = [aws_security_group.public.id]
  associate_public_ip_address = true
  tags = {
    Terraform = "true"
    Name = "Public-instance"
  }
}

resource "aws_instance" "private" {
  ami                    = data.aws_ami.debian12.id
  key_name               = aws_key_pair.main.key_name
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.private.id
  vpc_security_group_ids = [aws_security_group.private.id]
  tags = {
    Terraform = "true"
    Name = "Private-instance"
  }
}

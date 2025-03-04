data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

resource "aws_instance" "app" {
  for_each = toset(var.subnet_ids)

  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"
  subnet_id     = each.value

  tags = {
    Name = "app-instance"
  }
}

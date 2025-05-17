#custom vpc creation
resource "aws_vpc" "custom_vpc" {
  cidr_block       = var.cidr_block

  tags = {
    Name = "custom_vpc"
  }
}
#internet gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.custom_vpc.id

  tags = {
    Name = "custom_vpc"
  }
}

#websubnet
resource "aws_subnet" "websubnet" {
  vpc_id     = aws_vpc.custom_vpc.id
  cidr_block = var.web-cidr_block
  availability_zone = "us-east-1a"
  tags = {
    Name = "websubnet"
  }
}

#app subnet

resource "aws_subnet" "appsubnet" {
  vpc_id     = aws_vpc.custom_vpc.id
  cidr_block = var.app-cidr_block
  availability_zone = "us-east-1a"
  tags = {
    Name = "appsubnet"
  }
}

#db-subnet

resource "aws_subnet" "dbsubnet" {
  vpc_id     = aws_vpc.custom_vpc.id
  cidr_block = var.db-cidr_block
  availability_zone = "us-east-1b"
  tags = {
    Name = "dbsubnet"
  }
}
#db_subnet group
resource "aws_db_subnet_group" "default" {
  name       = "main"
  subnet_ids = [aws_subnet.appsubnet.id, aws_subnet.dbsubnet.id]

  tags = {
    Name = "My-DB-subnet-group"
  }
}


#variables
variable "cidr_block"{
    default = "10.0.0.0/16"
}

variable "web-cidr_block"{
     default = "10.0.0.0/20"
}
variable "app-cidr_block"{
      default = "10.0.16.0/20"
}
variable "db-cidr_block"{
     default = "10.0.32.0/20"

}

output "vpc_id" {
    value = aws_vpc.custom_vpc.id
}
 
output "websubnet_id" {
    value = aws_subnet.websubnet.id
}
output "appsubnet_id" {
    value = aws_subnet.appsubnet.id
}

output "dbsubnet_id" {
    value = aws_subnet.dbsubnet.id
}
output "dbsubnet_group_name" {
  value = aws_db_subnet_group.default.name
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
  access_key = "****"
  secret_key = "****"
}


data "aws_ami" "latest-ubuntu" {
  most_recent = true
owners = ["880770118761"]

  filter {
      name   = "name"
      values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-20.04-amd64-server-*"]
  }

}


# 1 Create VPC
resource "aws_vpc" "my-first-vpc" {
  cidr_block       = "10.0.0.0/24"
  instance_tenancy = "default"

  tags = {
    Name = "VPC_Ubuntu"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.my-first-vpc.id

  tags = {
    Name = "internet-gw1"
  }
}


resource "aws_route_table" "first-route" {
  vpc_id = aws_vpc.my-first-vpc.id

  route {
     cidr_block = "0.0.0.0/0"
     gateway_id = aws_internet_gateway.gw.id
   }


  tags = {
    Name = "route1"
  }
}


# 4 Create a Subnet

resource "aws_subnet" "subnet-1" {
  vpc_id     = aws_vpc.my-first-vpc.id
  cidr_block = "10.0.0.0/25"

  tags = {
    Name = "VPC_Ubuntu_subnet"
  }
}

# 4.1 Create a Subnet

resource "aws_subnet" "subnet-2" {
  vpc_id     = aws_vpc.my-first-vpc.id
  cidr_block = "10.0.0.128/25"

  tags = {
    Name = "VPC_CentOS_subnet"
  }
}

# 5. Associate subnet with Route Table

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.subnet-1.id
  route_table_id = aws_route_table.first-route.id

  
}

# 5.1 Associate subnet with Route Table

resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.subnet-2.id
  route_table_id = aws_route_table.first-route.id

  
}

# 6. Create Security Group to allow port 22, 80, 443

resource "aws_security_group" "allow_web" {
  name        = "allow_web_traffic"
  description = "Allow Web inbound traffic"
  vpc_id      = aws_vpc.my-first-vpc.id

tags = {
    Name = "allow_web"
  }

}


resource "aws_security_group_rule" "allow_web_out" { 

      type             = "egress"
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"] 

      security_group_id = aws_security_group.allow_web.id

}


resource "aws_security_group_rule" "allow_web_in_https" { 

      type = "ingress"
      description      = "HTTPS"
      from_port        = 443
      to_port          = 443
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"] 
      
       security_group_id = aws_security_group.allow_web.id

}
    resource "aws_security_group_rule" "allow_web_in_http" {

      type             = "ingress"
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"] 
      
      security_group_id = aws_security_group.allow_web.id
    }

    resource "aws_security_group_rule" "allow_web_in_ssh"{
      type             = "ingress"
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"] 

     security_group_id = aws_security_group.allow_web.id
    }


resource "aws_security_group_rule" "allow_web_in_icmp" { 

      type = "ingress"
      description      = "ICMP"
      from_port        = -1
      to_port          = -1
      protocol         = "icmp"
      cidr_blocks      = ["0.0.0.0/0"] 
      
       security_group_id = aws_security_group.allow_web.id

}

 # 6.1 Create Security Group Private to allow port 22, 80, 443

resource "aws_security_group" "private" {
  name        = "allow__traffic"
  description = "Private traffic"
  vpc_id      = aws_vpc.my-first-vpc.id

tags = {
    Name = "allow_private"
  }

}

resource "aws_security_group_rule" "private_out_https" { 

      type = "egress"
      description      = "HTTPS"
      from_port        = 443
      to_port          = 443
      protocol         = "tcp"
      cidr_blocks      = [aws_subnet.subnet-1.cidr_block] 

      security_group_id = aws_security_group.private.id

}


resource "aws_security_group_rule" "private_out_http" { 

     type             = "egress"
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      cidr_blocks      = [aws_subnet.subnet-1.cidr_block] 

      security_group_id = aws_security_group.private.id

}


resource "aws_security_group_rule" "private_out_ssh" { 

     type             = "egress"
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = [aws_subnet.subnet-1.cidr_block] 

      security_group_id = aws_security_group.private.id

}


resource "aws_security_group_rule" "private_out_icmp" { 

     type             = "egress"
      from_port        = -1
      to_port          = -1
      protocol         = "icmp"
      cidr_blocks      = [aws_subnet.subnet-1.cidr_block] 

      security_group_id = aws_security_group.private.id

}

resource "aws_security_group_rule" "private_in_https" { 

      type = "ingress"
      description      = "HTTPS"
      from_port        = 443
      to_port          = 443
      protocol         = "tcp"
      cidr_blocks      = [aws_vpc.my-first-vpc.cidr_block] 

      security_group_id = aws_security_group.private.id

}


resource "aws_security_group_rule" "private_in_http" { 

     type             = "ingress"
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      cidr_blocks      = [aws_vpc.my-first-vpc.cidr_block] 

      security_group_id = aws_security_group.private.id

}


resource "aws_security_group_rule" "private_in_ssh" { 

     type             = "ingress"
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = [aws_vpc.my-first-vpc.cidr_block] 

      security_group_id = aws_security_group.private.id

}


resource "aws_security_group_rule" "private_in_icmp" { 

     type             = "ingress"
      from_port        = -1
      to_port          = -1
      protocol         = "icmp"
      cidr_blocks      = [aws_vpc.my-first-vpc.cidr_block] # give 1 ip add if you want 1 access

      security_group_id = aws_security_group.private.id

}

# 7. Create network interface with an ip in the subnet that was created in step 4

resource "aws_network_interface" "web-server-nic" {
  subnet_id       = aws_subnet.subnet-1.id
  private_ips     = ["10.0.0.50"]
  security_groups = [aws_security_group.allow_web.id]


}

# 7.1. Create network interface with an ip in the subnet that was created in step 4

resource "aws_network_interface" "centos-server-nic" {
  subnet_id       = aws_subnet.subnet-2.id
  private_ips     = ["10.0.0.150"]
  security_groups = [aws_security_group.private.id]


}

# 8. Elastic IP address

resource "aws_eip" "one" {
  vpc                       = true
  network_interface         = aws_network_interface.web-server-nic.id
  associate_with_private_ip = "10.0.0.50"
  depends_on = [ aws_internet_gateway.gw ]
}



# 9. Create Ubuntu server and install/enable apache2

resource "aws_instance" "my-first-server" {
  ami           = "ami-09e67e426f25ce0d7" # "${data.aws_ami.latest-ubuntu.id}"
  instance_type = "t2.micro"
  key_name = "m-key"

  network_interface {
    device_index = 0
    network_interface_id = aws_network_interface.web-server-nic.id
  }

  user_data = <<-EOF
                #!/bin/bash
                sudo apt update -y
                sudo apt install apache2 -y
                sudo systemctl start apache2
                curl -fsSL https://get.docker.com -o get-docker.sh
                sudo sh get-docker.sh
                sudo bash -c 'echo Hello world, lsb_release -a > /var/www/html/index.html'
                sudo bash -c 'lsb_release -a >> /var/www/html/index.html'
                sudo bash -c 'sudo docker run hello-world >> /var/www/html/index.html'
  EOF

  tags = {
         Name = "Ubuntu"
   }
}

# 10. Create CentOS server

resource "aws_instance" "my-second-server" {
  ami           = "ami-0affd4508a5d2481b"
  instance_type = "t2.micro"
  key_name = "m-key"

  network_interface {
    device_index = 0
    network_interface_id = aws_network_interface.centos-server-nic.id
  }

    tags = {
         Name = "CentOS"
   }
}

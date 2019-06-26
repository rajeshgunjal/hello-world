
#resource "aws_key_pair" "devlogin" {
#key_name = "devlogin"
#public_key = "${file("C:\AWS\devlogin.pub")}"
#}


## Security Group

resource "aws_security_group" "DEV_SG" {
    name = "Dev-vpc"
    description = "Allow incoming HTTP and SSH connections."

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    
    vpc_id = "${aws_vpc.Dev-vpc.id}"

    tags {
        Name = "WebServerSG"
    }
}

##  Create Key pair

variable "key_name" {}

resource "tls_private_key" "devlogin" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "devlogin" {
  key_name   = "${var.key_name}"
  public_key = "${tls_private_key.devlogin.public_key_openssh}"
}


## Launch Instance 

resource "aws_instance" "DEV_Webserver" {
    ami = "ami-035b3c7efe6d061d5"
    availability_zone = "us-east-1a"
    instance_type = "t2.micro"
    key_name = "${aws_key_pair.devlogin.key_name}"
    vpc_security_group_ids = ["${aws_security_group.DEV_SG.id}"]
    subnet_id = "${aws_subnet.public-subnet.id}"
    associate_public_ip_address = true
    source_dest_check = false


    tags {
        Name = "DEV_Webserver"
    }
}

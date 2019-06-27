

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



## Launch Instance 

resource "aws_instance" "DEV_Webserver" {
    ami = "ami-07b4156579ea1d7ba"
    availability_zone = "us-east-1a"
    instance_type = "t2.micro"
    key_name = "bastionhost"
    vpc_security_group_ids = ["${aws_security_group.DEV_SG.id}"]
    subnet_id = "${aws_subnet.public-subnet.id}"
    associate_public_ip_address = true
    source_dest_check = false


    tags {
        Name = "DEV_Webserver"
    }
}

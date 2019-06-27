## Variable Declaration ##

## VPC Variable

variable "aws_region" { 
   description = "Region for the VPC" 
   default = "us-east-1" 
} 

variable "cidr" {
  description = "CIDR for the VPC"
  default = "10.0.0.0/16"
}

## Public Sub variable

variable "pub_sub" {
  description = "CIDR for the public subnet"
  default = "10.0.1.0/24"
}

## Private Sub variable

variable "prv_sub" {
  description = "CIDR for the private subnet"
  default = "10.0.2.0/24"
}


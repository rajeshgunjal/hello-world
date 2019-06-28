## Disk Add

provider "aws" {
  region     = "us-east-1"
  access_key = ""
  secret_key = ""
} 

resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/sdh"
  volume_id   = "${aws_ebs_volume.test_vol.id}"
  instance_id = "i-037c375e71a9bcd39"
}

resource "aws_ebs_volume" "test_vol" {
  availability_zone = "us-east-1a"
  size              = 8
}
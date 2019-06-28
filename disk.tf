## Disk Add

provider "aws" {
  region     = "us-east-1"
  access_key = "AKIA2XBEWL5Z36G4A3VG"
  secret_key = "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"
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
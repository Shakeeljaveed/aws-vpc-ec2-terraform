
 resource "aws_key_pair" "userdefined_name" {
   key_name = "userdefined_key_name"
   public_key = "copy your ssh public key here"
 }



resource "aws_instance" "userdefined_instance_name" {
   ami  = "${var.ami}"
   instance_type = "t2.micro"
   key_name = "${aws_key_pair.userdefined_name.id}"
   subnet_id = "${aws_subnet.public-subnet.id}"
   vpc_security_group_ids = ["${aws_security_group.sg-terra.id}"]
   associate_public_ip_address = true
   source_dest_check = false
   user_data = "${file("install.sh")}"

  tags {
    Name = "servername"
  }
}

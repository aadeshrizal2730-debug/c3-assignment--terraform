resource "aws_launch_template" "web" {
  name_prefix   = "web-lt-"
  image_id      = "ami-0c02fb55956c7d316"
  instance_type = "t3.micro"
  user_data     = base64encode(file("userdata.sh"))

  vpc_security_group_ids = [aws_security_group.web.id]
}


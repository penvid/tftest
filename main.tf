data "aws_availability_zones" "available" {}

variable "server_port" {

    description = "the port the server will use for HTTP requests"
    type = number
    default = 80

}

variable "ssh_port" {
    description = "the port to ssh"
    type = number
    default = 22
}

variable "elb_port" {

    description = "the port the load balancer will use for HTTP requests"
    type = number
    default = 80

}

provider "aws" {
   region = "us-east-1"
   shared_credentials_file = "/root/.aws/credentials"
   profile = "default"
}

resource "random_id" "example_bucket_id" {
   byte_length = 2
}

resource "aws_s3_bucket" "example_bucket" {
   bucket = "myvid-${random_id.example_bucket_id.dec}"
   acl = "private"
   force_destroy = true

   tags = {
       Name = "Myvidbuckete"
   }
}

resource "aws_security_group" "instance"{
    name = "terraform-example-instance"

    ingress {
      from_port = "${var.server_port}"
      to_port = "${var.server_port}"
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }

   ingress {
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
   
    egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  } 

}


#resource "aws_instance" "example" {
#   ami  = "ami-00dc79254d0461090"
#   instance_type = "t2.micro"
#   key_name="mykeyAWS"
#   vpc_security_group_ids = [aws_security_group.instance.id]
#
#  user_data = <<-EOF
#               #!/bin/bash
#               sudo yum -y update
#               sudo yum install -y httpd
#               echo "<h1>Deployed via terraform</h1>" | sudo tee /var/www/html/index.html
#               systemctl start httpd
#               systemctl enable httpd
#               EOF
#
#   tags = {
#      Name = "terraform-example"
#   }
#}

resource "aws_launch_configuration" "example" {
     image_id = "ami-00dc79254d0461090"
     instance_type = "t2.micro"
     security_groups = [aws_security_group.instance.id]
     
     user_data = <<-EOF
               #!/bin/bash
               sudo yum -y update
               sudo yum install -y httpd
               echo "<h1>Deployed via terraform</h1>" | sudo tee /var/www/html/index.html
               systemctl start httpd
               systemctl enable httpd
               EOF

      lifecycle {
          create_before_destroy = true
      }
}

resource "aws_autoscaling_group" "example" {
      launch_configuration = "${aws_launch_configuration.example.id}"
      availability_zones =   "${data.aws_availability_zones.available.names}"

      min_size = 2
      max_size = 4

      load_balancers = [aws_elb.example.name]
      health_check_type = "ELB"

      tag {
          key = "Name"
          value = "terraform_asg_example"
          propagate_at_launch = true
          
          

       }

}


resource "aws_elb" "example" {
    name = "terraform-asg-example"
    security_groups = [aws_security_group.instance.id]
    availability_zones =   "${data.aws_availability_zones.available.names}"

    health_check {
      target = "HTTP:${var.server_port}/"
      interval = 30
      timeout = 3
      healthy_threshold = 2
      unhealthy_threshold = 2
    }    

    listener {
        lb_port = var.elb_port
        lb_protocol = "http"
        instance_port = var.server_port
        instance_protocol = "http"

    }   

}

#   output "public_ip" {
#   value = "${aws_instance.example.public_ip}"
#   description = "The public IP of the web server"
#}

output "clb_dns_name" {
   value = aws_elb.example.dns_name
   description = "The domain name of the loda balancer"
}



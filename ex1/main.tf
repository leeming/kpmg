# Get all instances to report IP address for debugging purposes
data template_file example_nginx {
  template = <<EOF
#!/bin/bash
yum update
yum -y install nginx
echo "$(curl http://169.254.169.254/latest/meta-data/local-ipv4)" > /usr/share/nginx/html/index.html
chkconfig nginx on
service nginx start
  
EOF
}

## Frontend
resource aws_elb frontend {
  name    = "frontend-lb"
  subnets = var.subnets


  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  security_groups = [ var.sg ]

  cross_zone_load_balancing   = true
}

resource aws_launch_template frontend {
  name_prefix   = "frontend"
  image_id      = var.frontend_ami
  instance_type = "t3.micro"
  key_name      = "kpmg"

  user_data = base64encode(data.template_file.example_nginx.rendered)
}

resource aws_autoscaling_group frontend {
  vpc_zone_identifier = var.subnets

  desired_capacity   = 2
  max_size           = 2
  min_size           = 2

  launch_template {
    id      = aws_launch_template.frontend.id
    version = "$Latest"
  }

  load_balancers = [ aws_elb.frontend.name ]
}


## Backend
resource aws_elb backend {
  name    = "backend-lb"
  subnets = var.subnets


  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  security_groups = [ var.sg ]

  cross_zone_load_balancing   = true

}

resource aws_launch_template backend {
  name_prefix   = "backend"
  image_id      = var.backend_ami
  instance_type = "t3.micro"
  key_name      = "kpmg"

  user_data = base64encode(data.template_file.example_nginx.rendered)
}

resource aws_autoscaling_group backend {
  vpc_zone_identifier = var.subnets  

  desired_capacity   = 2
  max_size           = 2
  min_size           = 2

  launch_template {
    id      = aws_launch_template.backend.id
    version = "$Latest"
  }

  load_balancers = [ aws_elb.backend.name ]
}


## Database
resource aws_db_instance storage {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  name                 = "applicationdb"
  username             = "applicationfoo"
  password             = "$uperS3cret"
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot = true
}


output frontend_dns {
	value = aws_elb.frontend.dns_name
}
output backendend_dns {
    value = aws_elb.backend.dns_name
}
output db_dns {
	value = aws_db_instance.storage.address
}


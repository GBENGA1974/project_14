data "aws_ami" "windows" {
  most_recent = true

  filter {
    name   = "name"
    values = ["Windows_Server-2019-English-Full-Base-*"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["801119661308"] # Canonical
}

resource "aws_security_group" "ec2_sg" {
  name        = "ec2_sg"
  description = "allow all ec2"
  vpc_id      = aws_vpc.project14_vpc.id
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sg"
  }
}

resource "aws_instance" "lunch-config" {
    ami      = data.aws_ami.windows.id
    instance_type = "t2.micro"
    availability_zone = "eu-west-1a"

    lifecycle {
        create_before_destroy = true
      }
}

resource "aws_ebs_volume" "block_storage" {
    availability_zone = "eu-west-1a"
    size = 8
}

resource "aws_volume_attachment" "ebs_att" {
    device_name = "/dev/sdh"
    volume_id = aws_ebs_volume.block_storage.id
    instance_id = aws_instance.lunch-config.id
}

resource "aws_cloudwatch_metric_alarm" "ec2_cpu" {
    alarm_name = "cpu-utilization"
    comparison_operator = "GreaterThanOrEqualToThreshold"
    evaluation_periods = "2"
    metric_name = "CPUUtilization"
    namespace = "AWS/EC2"
    period = "60" #seconds
    statistic = "Average"
    threshold = "80"
    alarm_description = "This metric monitors ec2 cpu utilization"
    insufficient_data_actions = []

    dimensions = {
        instanceId = aws_instance.lunch-config.id
    }
}
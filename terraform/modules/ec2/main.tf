
#  default VPCを取得
data "aws_vpc" "default" {
    default = true
}

# default subnetを取得
data "aws_subnet" "default" {
    vpc_id = data.aws_vpc.default.id
    availability_zone = "${var.aws_region}a"
    default_for_az = true
}

# 最新のAmazon Linux 2 AMIを取得
data "aws_ami" "latest_amazon_linux_2" {
    most_recent = true
    owners = ["amazon"]

    filter {
        name   = "name"
        values = ["amzn2-ami-hvm-*-x86_64-gp2"]
    }

    filter {
      name = "virtualization-type"
      values = ["hvm"]
    }
}

# セキュリティグループ
resource "aws_security_group" "web" {
    name_prefix = "${var.project_name}-web-"
    vpc_id = data.aws_vpc.default.id

    # HTTP(ポート80)からのアクセスを許可
    ingress {
        from_port = 80
        to_port   = 80
        protocol  = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    # SSH(ポート22) からのアクセスを許可
    ingress {
        from_port = 22
        to_port   = 22
        protocol  = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    # 全てのアウトバウンドトラフィックを許可
    egress {
        from_port = 0
        to_port   = 0
        protocol  = "-1" # -1は全てのプロトコルを意味する
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "${var.project_name}-web-sg"
    }
}

# EC2インスタンス
resource "aws_instance" "web" {
    ami =  data.aws_ami.latest_amazon_linux_2.id
    instance_type = var.instance_type
    subnet_id = data.aws_subnet.default.id
    vpc_security_group_ids = [aws_security_group.web.id]

    user_data = <<-EOF
        #!/bin/bash
        yum update -y
        yum install -y httpd
        systemctl start httpd
        systemctl enable httpd
        echo "<h1>Hello, World!</h1>" > /var/www/html/index.html
    EOF

    tags = {
        Name = "${var.project_name}-web-server"
    }
}
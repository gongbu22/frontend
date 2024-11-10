terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
provider "aws" {
  region = "ap-northeast-2"
}

// ansible
resource "aws_instance" "ansible" {
  ami           = "ami-056a29f2eddc40520" # Ubuntu 22.04 LTS
  instance_type = "t2.micro"
  key_name      = "clouds2024" # 키페어 이름

  root_block_device {
    volume_size = 8
    volume_type = "gp3"
    delete_on_termination = true  # 인스턴스 종료시 볼륨도 삭제
  }

  disable_api_termination = true  # 종료 방지 활성화
  vpc_security_group_ids = ["sg-083d7a16c698d056a"]

  user_data = <<-EOF
    #!/bin/bash
    sudo timedatectl set-timezone "Asia/Seoul"
    sudo hwclock
    sudo hostnamectl set-hostname ansible

    sudo apt update -y

    # Ansible 설치
    sudo apt install -y software-properties-common
    sudo add-apt-repository --yes --update ppa:ansible/ansible
    sudo apt install -y ansible
  EOF

  tags = {
    Name = "ansible-parking"
  }
}

// ci
resource "aws_instance" "ci" {
  ami           = "ami-056a29f2eddc40520" # Ubuntu 22.04 LTS
  instance_type = "t3.small"
  key_name      = "clouds2024" # 키페어 이름

  root_block_device {
    volume_size = 30
    volume_type = "gp3"
    delete_on_termination = true  # 인스턴스 종료시 볼륨도 삭제
  }

  disable_api_termination = true  # 종료 방지 활성화
  vpc_security_group_ids = ["sg-083d7a16c698d056a"]

  user_data = <<-EOF
    #!/bin/bash
    sudo timedatectl set-timezone "Asia/Seoul"
    sudo hwclock
    sudo hostnamectl set-hostname ci
  EOF

  tags = {
    Name = "ci"
  }
}

// cd-master
resource "aws_instance" "cd-master" {
  ami           = "ami-056a29f2eddc40520" # Ubuntu 22.04 LTS
  instance_type = "t3.small"
  key_name      = "clouds2024" # 키페어 이름

  root_block_device {
    volume_size = 30
    volume_type = "gp3"
    delete_on_termination = true  # 인스턴스 종료시 볼륨도 삭제
  }

  disable_api_termination = true  # 종료 방지 활성화
  vpc_security_group_ids = ["sg-083d7a16c698d056a"]

  user_data = <<-EOF
    #!/bin/bash
    sudo timedatectl set-timezone "Asia/Seoul"
    sudo hwclock
    sudo hostnamectl set-hostname cd-master
  EOF

  tags = {
    Name = "cd-master"
  }
}

// worker
resource "aws_instance" "worker" {
  ami           = "ami-056a29f2eddc40520" # Ubuntu 22.04 LTS
  instance_type = "t3.small"
  key_name      = "clouds2024" # 키페어 이름

  root_block_device {
    volume_size = 30
    volume_type = "gp3"
    delete_on_termination = true  # 인스턴스 종료시 볼륨도 삭제
  }

  disable_api_termination = true  # 종료 방지 활성화
  vpc_security_group_ids = ["sg-083d7a16c698d056a"]

  user_data = <<-EOF
    #!/bin/bash
    sudo timedatectl set-timezone "Asia/Seoul"
    sudo hwclock
    sudo hostnamectl set-hostname worker
  EOF

  tags = {
    Name = "worker"
  }
}



output "ansible-parking" {   # 인스턴스 ansible-parking 퍼블릭 IP 주소
  value = aws_instance.ansible.public_ip
}

output "ci" {   # 인스턴스 ci 퍼블릭 IP 주소
  value = aws_instance.ci.public_ip
}

output "cd-master" {   # 인스턴스 cd-master 퍼블릭 IP 주소
  value = aws_instance.cd-master.public_ip
}

output "worker" {   # 인스턴스 worker 퍼블릭 IP 주소
  value = aws_instance.worker.public_ip
}



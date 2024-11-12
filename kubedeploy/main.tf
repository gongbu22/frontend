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
resource "aws_instance" "arm_ansible" {
  ami           = "ami-0a9ca67a102bd2bc8" # Ubuntu 22.04 LTS
  instance_type = "t4g.micro"
  key_name      = "clouds2024" # 키페어 이름

  root_block_device {
    volume_size = 8
    volume_type = "gp3"
    delete_on_termination = true  # 인스턴스 종료시 볼륨도 삭제
  }

  disable_api_termination = true  # 종료 방지 활성화
  vpc_security_group_ids = ["sg-0d2211537b7b269e8"]

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

    # gitops 폴더 생성
    mkdir -p /home/ubuntu/gitops
    sudo chown ubuntu:ubuntu /home/ubuntu/gitops
    sudo chmod 755 /home/ubuntu/gitops

    # inventory 생성
    cat <<INVENTORY >  /home/ubuntu/gitops/inventory
    [gitops]
    ci ansible_host=${aws_instance.arm_ci.public_ip} ansible_user=ubuntu
    cd-master ansible_host=${aws_instance.arm_cd-master.public_ip} ansible_user=ubuntu

    [workers]
    worker ansible_host=${aws_instance.arm_worker.public_ip} ansible_user=ubuntu

    [all:vars]
    ansible_ssh_private_key_file=/home/ubuntu/clouds2024.pem
    ansible_ssh_common_args='-o StrictHostKeyChecking=no'
    ansible_python_interpreter=/usr/bin/python3.10
    INVENTORY
  EOF

  tags = {
    Name = "arm-ansible"
  }
}

// ci
resource "aws_instance" "arm_ci" {
  ami           = "ami-0a9ca67a102bd2bc8" # Ubuntu 22.04 LTS
  instance_type = "t4g.small"
  key_name      = "clouds2024" # 키페어 이름

  root_block_device {
    volume_size = 30
    volume_type = "gp3"
    delete_on_termination = true  # 인스턴스 종료시 볼륨도 삭제
  }

  disable_api_termination = true  # 종료 방지 활성화
  vpc_security_group_ids = ["sg-0d2211537b7b269e8"]

  user_data = <<-EOF
    #!/bin/bash
    sudo timedatectl set-timezone "Asia/Seoul"
    sudo hwclock
    sudo hostnamectl set-hostname ci
  EOF

  tags = {
    Name = "arm-ci"
  }
}

// cd-master
resource "aws_instance" "arm_cd-master" {
  ami           = "ami-0a9ca67a102bd2bc8" # Ubuntu 22.04 LTS
  instance_type = "t4g.medium"
  key_name      = "clouds2024" # 키페어 이름

  root_block_device {
    volume_size = 30
    volume_type = "gp3"
    delete_on_termination = true  # 인스턴스 종료시 볼륨도 삭제
  }

  disable_api_termination = true  # 종료 방지 활성화
  vpc_security_group_ids = ["sg-0d2211537b7b269e8"]

  user_data = <<-EOF
    #!/bin/bash
    sudo timedatectl set-timezone "Asia/Seoul"
    sudo hwclock
    sudo hostnamectl set-hostname cd-master
  EOF

  tags = {
    Name = "arm-cd-master"
  }
}

// worker
resource "aws_instance" "arm_worker" {
  ami           = "ami-0a9ca67a102bd2bc8" # Ubuntu 22.04 LTS
  instance_type = "t4g.small"
  key_name      = "clouds2024" # 키페어 이름

  root_block_device {
    volume_size = 30
    volume_type = "gp3"
    delete_on_termination = true  # 인스턴스 종료시 볼륨도 삭제
  }

  disable_api_termination = true  # 종료 방지 활성화
  vpc_security_group_ids = ["sg-0d2211537b7b269e8"]

  user_data = <<-EOF
    #!/bin/bash
    sudo timedatectl set-timezone "Asia/Seoul"
    sudo hwclock
    sudo hostnamectl set-hostname worker
  EOF

  tags = {
    Name = "arm-worker"
  }
}


output "ansible-parking" {   # 인스턴스 ansible-parking 퍼블릭 IP 주소
  value = aws_instance.arm_ansible.public_ip
}

output "ci" {   # 인스턴스 ci 퍼블릭 IP 주소
  value = aws_instance.arm_ci.public_ip
}

output "cd-master" {   # 인스턴스 cd-master 퍼블릭 IP 주소
  value = aws_instance.arm_cd-master.public_ip
}

output "worker" {   # 인스턴스 worker 퍼블릭 IP 주소
  value = aws_instance.arm_worker.public_ip
}

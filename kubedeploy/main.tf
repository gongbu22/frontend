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

# aws_instance는 변수 타입, tfOne은 변수명
resource "aws_instance" "tfOne" {
  ami           = "ami-056a29f2eddc40520" # Ubuntu 22.04 LTS
  instance_type = "t2.micro"
  key_name      = "clouds2024" # 키페어 이름

  root_block_device {
    volume_size = 30
    volume_type = "gp3"
    delete_on_termination = true  # 인스턴스 종료시 볼륨도 삭제
  }

  disable_api_termination = true  # 종료 방지 활성화
  vpc_security_group_ids = ["sg-보안그룹 id"]

  tags = {
    Name = "tfOne"
  }
}

output "instance_public_ip" {   # 인스턴스 퍼블릭 IP 주소
  value = aws_instance.tfOne.public_ip
}
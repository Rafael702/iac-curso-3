//Especificacao do provedor
terraform {
  required_providers { //provedores necessarios para criar a nossa instancia.
    aws = {
      source  = "hashicorp/aws" //provider para acessar a aws.
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  profile = "default"
  region = var.regiao_aws
}

resource "aws_instance" "app_server" {
    ami           = var.ami // Imagem do sistema
    instance_type = var.instancia
    key_name      = var.chave
   
    tags = {
        Name = "Terraform Ansible Python"
    }
}

resource "aws_key_pair" "chaveSSH"{
  key_name = var.chave
  public_key = file("${var.chave}.pub")
}

output "IP_publico" {
value = aws_instance.app_server.public_ip //traz informacao do ip
}

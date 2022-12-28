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

resource "aws_launch_template" "maquina" {
    image_id           = var.ami // Imagem do sistema
    instance_type = var.instancia
    key_name      = var.chave
   
    tags = {
        Name = "Terraform Ansible Python"
    }
    security_group_names = [var.grupoDeSeguranca]
    user_data = filebase64("ansible.sh") //coloca o script em uma base de 64 caracteres
}

resource "aws_key_pair" "chaveSSH"{
  key_name = var.chave
  public_key = file("${var.chave}.pub")
}

resource "aws_autoscaling_group" "grupo" {
  availability_zones = ["${var.regiao_aws}a"]
  name = var.nomeGrupo
  max_size = var.maximo
  min_size = var.minimo
  launch_template {
    id = aws_launch_template.maquina.id
    version = "$Latest"
  }
  }
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
  availability_zones = ["${var.regiao_aws}a", "${var.regiao_aws}b"] //zona de disponibilidade
  name = var.nomeGrupo
  max_size = var.maximo
  min_size = var.minimo
  launch_template {
    id = aws_launch_template.maquina.id
    version = "$Latest"
  }
  target_group_arns = [ aws_lb_target_group.alvoLoadBalancer.arn ]
  }

//redes internas na aws
  resource "aws_default_subnet" "subnet_1" { 
    availability_zone = "${var.regiao_aws}a" 
  }

  resource "aws_default_subnet" "subnet_2" {
    availability_zone = "${var.regiao_aws}b" 
  }

//Distribuidor de carga
  resource "aws_lb" "loadBalancerProducao" {
    internal = false
    subnets = [aws_default_subnet.subnet_1.id,aws_default_subnet.subnet_2.id ]
  }

  resource "aws_default_vpc" "default" {

  }

  resource "aws_lb_target_group" "alvoLoadBalancer" {
    name     = "maquinaAlvo"
    port     = "8000"
    protocol = "HTTP"
    vpc_id   =  aws_default_vpc.default.id //Virtual Private Cloud
  }

resource "aws_listener" "entradaLoadBalancer" {
  load_balancer_arn = aws_lb.load_balancer_arn
  port = "8000"
  protocol = "HTTP"
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.alvoLoadBalancer.arn
  }
}

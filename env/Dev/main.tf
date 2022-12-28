#As variaveis declaradas na infra receberao o seu valor aqui.
module "aws-dev" {
  source = "../../infra"
  ami = "ami-0ecc74eca1d66d8a6"
  instancia  = "t2.micro"
  regiao_aws = "us-west-2"
  chave = "Iac-Dev"
  security_group_name = "acesso_geral_dev"
}

output "IP" {
  value = module.aws-dev.IP_publico
}
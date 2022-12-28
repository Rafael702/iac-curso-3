#As variaveis declaradas na infra receberao o seu valor aqui.
module "aws-prod" {
  source = "../../infra"
  ami = "ami-0ecc74eca1d66d8a6"
  instancia  = "t2.micro"
  regiao_aws = "us-west-2"
  chave = "Iac-prod"
  security_group_name = "acesso_geral_prod"
}

output "IP_Prod" {
  value = module.aws-prod.IP_publico
}

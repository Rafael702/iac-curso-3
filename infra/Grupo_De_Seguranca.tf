resource "aws_security_group" "acesso_geral" {
    name = var.security_group_name
    description = "grupo do Dev"
    ingress{
        cidr_blocks = ["0.0.0.0/0"] //ipv4 que pode entrar para todas as maquinas
        ipv6_cidr_blocks = ["::/0"]//aceita todas as conexoes do ipv6
        from_port = 0 //com 0 indicamos todas as portas disponiveis
        to_port = 0 //com 0 indicamos todas as portas disponiveis
        protocol = "-1" // libera todos os protocolos
    } //bloco de configuracao de entrada - request
    egress{
        cidr_blocks = ["0.0.0.0/0"] 
        ipv6_cidr_blocks = ["::/0"]
        from_port = 0
        to_port = 0
        protocol = "-1"
    } //bloco de configuracao de saida - response
    tags = {
        name = "acesso_geral"
    }
}
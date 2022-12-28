#Declaracao de variables
#Valores serao passados dentro dos ambientes
variable "regiao_aws" {
    type = string
}

variable "chave" {
    type = string
}

variable "instancia" {
    type = string
}

variable "ami" {
    type = string
}

variable "grupoDeSeguranca" {
    type = string
}

variable "minimo"{
    type = number
}

variable "maximo"{
    type = number
}

variable "nomeGrupo"{
    type = string
}
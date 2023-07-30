variable "region" {
  default     = "us-east-1"
  type        = string
  description = "Código da região AWS"
}

variable "name" {
  default     = "ugf-store"
  type        = string
  description = "Utilizado para nomear os recursos"
}

variable "docdb_password" {
  type        = string
  description = "Senha do DocumentDB"
}

variable "tags" {
  default = {
    Environment = "Demo"
  }
  type        = map(any)
  description = "Tags dos recursos"
}

variable "access_token_github" {
  type        = string
  description = "GitHub Access Token"
}

variable "api_url" {
  type        = string
  description = "Define URL da API"
}

variable "route53_domain" {
  type        = string
  description = "Define dominio do Route53"
}
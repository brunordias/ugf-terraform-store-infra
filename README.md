# ugf-terraform-store-infra
Projeto Terraform para o gerenciamento de recursos AWS para exemplificar o funcionamento de uma arquitetura de microsserviços.

![Diagram](/assets/img/diagram.jpeg)

## Resumo da arquitetura
* Cliente realiza conexão através de front-end **Amplify** e do **Application Load Balacer**.
* As conexões HTTP do **ALB** são encaminhadas ao serviço `store-resource`.
* `store-resource` é responsável por tratar as requisições HTTP e por encaminhar as requisições para os serviços `pets` e `order`, utilizando o serviço de descoberta do **Cloud Map** e protocolo gRPC.
* `pets` e `order` são responsáveis pelo controle destes serviços e interações necessárias com o banco **DocumentDB**.
* `listener` é responsável por consumir os eventos no **SNS** e **SQS**.
* É necessário que os serviços contenham uma política IAM atrelada para interação dos eventos no **SNS** e **SQS**.
* O banco DocumentDB publica sua senha em um segredo no **Secrets Manager**, os serviços utilizam esse valor via variável de ambiente.
* Os logs dos serviços são enviados ao **CloudWatch**.
* As métricas dos serviços são enviadas ao **Prometheus**.
* A visualização das métricas ocorre através do **Grafana**.


## Usage

To run this example you need to execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

Note that this example may create resources which cost money. Run `terraform destroy` when you don't need these resources.


## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.9.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_acm"></a> [acm](#module\_acm) | terraform-aws-modules/acm/aws | ~> 4.3.0 |
| <a name="module_alb_sg"></a> [alb\_sg](#module\_alb\_sg) | terraform-aws-modules/security-group/aws//modules/https-443 | ~> 4.0 |
| <a name="module_amplify"></a> [amplify](#module\_amplify) | brunordias/amplify-app/aws | ~> 1.0.0 |
| <a name="module_documentdb_cluster"></a> [documentdb\_cluster](#module\_documentdb\_cluster) | cloudposse/documentdb-cluster/aws | 0.22.0 |
| <a name="module_ecs_cluster"></a> [ecs\_cluster](#module\_ecs\_cluster) | brunordias/ecs-cluster/aws | ~> 2.0.0 |
| <a name="module_ecs_fargate_listener"></a> [ecs\_fargate\_listener](#module\_ecs\_fargate\_listener) | brunordias/ecs-fargate/aws | ~> 8.0.0 |
| <a name="module_ecs_fargate_order"></a> [ecs\_fargate\_order](#module\_ecs\_fargate\_order) | brunordias/ecs-fargate/aws | ~> 8.0.0 |
| <a name="module_ecs_fargate_pets"></a> [ecs\_fargate\_pets](#module\_ecs\_fargate\_pets) | brunordias/ecs-fargate/aws | ~> 8.0.0 |
| <a name="module_ecs_fargate_store_resource"></a> [ecs\_fargate\_store\_resource](#module\_ecs\_fargate\_store\_resource) | brunordias/ecs-fargate/aws | ~> 8.0.0 |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | terraform-aws-modules/vpc/aws | ~> 5.1.0 |

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_kms_key.docdb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_lb.alb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb) | resource |
| [aws_lb_listener.https](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) | resource |
| [aws_route53_record.api](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_secretsmanager_secret.docdb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret) | resource |
| [aws_secretsmanager_secret_version.docdb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_version) | resource |
| [aws_service_discovery_private_dns_namespace.local](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/service_discovery_private_dns_namespace) | resource |
| [aws_service_discovery_service.local](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/service_discovery_service) | resource |
| [aws_route53_zone.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_token_github"></a> [access\_token\_github](#input\_access\_token\_github) | GitHub Access Token | `string` | n/a | yes |
| <a name="input_api_url"></a> [api\_url](#input\_api\_url) | Define URL da API | `string` | n/a | yes |
| <a name="input_docdb_password"></a> [docdb\_password](#input\_docdb\_password) | Senha do DocumentDB | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Utilizado para nomear os recursos | `string` | `"ugf-store"` | no |
| <a name="input_region"></a> [region](#input\_region) | Código da região AWS | `string` | `"us-east-1"` | no |
| <a name="input_route53_domain"></a> [route53\_domain](#input\_route53\_domain) | Define dominio do Route53 | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags dos recursos | `map(any)` | <pre>{<br>  "Environment": "Demo"<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_alb_dns_name"></a> [alb\_dns\_name](#output\_alb\_dns\_name) | Use this URL to access your UGF Store API |
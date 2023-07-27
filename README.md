# ugf-terraform-store-infra
Projeto Terraform para o gerenciamento de recursos AWS para exemplificar o funcionamento de uma arquitetura de microsserviços.

![Diagram](/assets/img/diagram.jpeg)

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
| <a name="module_alb_sg"></a> [alb\_sg](#module\_alb\_sg) | terraform-aws-modules/security-group/aws//modules/http-80 | ~> 4.0 |
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
| [aws_lb_listener.http](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) | resource |
| [aws_secretsmanager_secret.docdb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret) | resource |
| [aws_secretsmanager_secret_version.docdb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_version) | resource |
| [aws_service_discovery_private_dns_namespace.local](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/service_discovery_private_dns_namespace) | resource |
| [aws_service_discovery_service.local](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/service_discovery_service) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_docdb_password"></a> [docdb\_password](#input\_docdb\_password) | Senha do DocumentDB | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Utilizado para nomear os recursos | `string` | `"ugf-store"` | no |
| <a name="input_region"></a> [region](#input\_region) | Código da região AWS | `string` | `"us-east-1"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags dos recursos | `map(any)` | <pre>{<br>  "Environment": "Demo"<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_alb_dns_name"></a> [alb\_dns\_name](#output\_alb\_dns\_name) | Use this URL to access your UGF Store API |
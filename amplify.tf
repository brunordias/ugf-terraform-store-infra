module "amplify" {
  source  = "brunordias/amplify-app/aws"
  version = "~> 1.0.0"

  name                     = var.name
  description              = "My Amplify APP"
  repository               = "https://github.com/brunordias/ugf-angular-store"
  access_token             = var.access_token_github
  enable_branch_auto_build = true
  app_environment = {
    API_HOST = "https://${var.api_url}"
  }
  branches_config = {
    main = {
      branch_name = "main"
    }
  }
}

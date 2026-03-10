locals {
  #############
  # VARIABLES #
  #############
  aws_profile = "my-profile"

  eks_node_groups = {
    "essential" = {
      name           = "essential"
      instance_types = ["t3.medium"]
      min_size       = 2 # @TODO -> Complete in env.hcl
      max_size       = 2 # @TODO -> Complete in env.hcl
      desired_size   = 2 # @TODO -> Complete in env.hcl
      ami_type       = "AL2023_x86_64_STANDARD"
    }
  }

  ###########
  # IMPORTS #
  ###########
  main = read_terragrunt_config("main.hcl").inputs
}

inputs = {
  ######################
  # PROVIDER VARIABLES #
  ######################
  # Tags for resources (for AWS providers)
  # See recommended AWS tags : <>
  aws_default_provider = {
    region           = local.main.region
    profile          = local.aws_profile
    # eks_cluster_name = local.main.env
    # eks_role_name    = local.eks_admin_roles[0]
    default_tags = {
      Environment   = local.main.env
      Project       = local.main.project_name
      Terraform     = true
      Module        = local.main.module
      Owner         = local.main.owner
    }
  }

  ###################
  # EKS Node Groups #
  ###################
  eks_node_groups = local.eks_node_groups

  # Create AWS private links on private subnets
  #  See ./network.hcl for subnet configuration
  aws_interface_private_links = true ? [] : [
    "secretsmanager",       # Secrets manager (to retrieve secrets in AWS vault)
    "ecr.dkr",              # Repository docker to get docker images
    "ecr.api",              # docker repository api
    "logs",                 # used for private services to create logs
    "ec2",                  # used by EKS
    "sts",                  # Used for authentication and IAM roles
    "elasticloadbalancing", # If EKS use load balancer
    "eks",                  # Communication with the controle-plane
  ]
}

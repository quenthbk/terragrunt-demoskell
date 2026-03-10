locals {
  namespaces = {
    "istio" = {
      name = "istio-system"
    }
    "cnpg" = {
      name = "cnpg"
    }
    "db" = {
      name = "db"
    }
    "main" = {
      name = "main"
    }
  }

  ###########
  # IMPORTS #
  ###########
  main = read_terragrunt_config("main.hcl").inputs
}

inputs = {
  k8s_namespaces = local.namespaces
  kubernetes_default_provider = {
    config_path    = local.main.env == "local" ? "~/.kube/config" : "~/.kube/${local.main.project_name}-${local.main.region}-${local.main.env}.yaml"
    config_context = local.main.env == "local" ? "minikube" : null
  }

  k8s_labels = {
    "app.kubernetes.io/part-of"    = local.main.project_name
    "app.kubernetes.io/managed-by" = "Terraform"
  }
}

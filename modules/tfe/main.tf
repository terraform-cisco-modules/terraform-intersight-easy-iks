#__________________________________________________________
#
# App Hello Workspaces
#__________________________________________________________

module "app_workspaces" {
  source              = "terraform-cisco-modules/modules/tfe//modules/tfc_workspace"
  for_each = {
    for k, v in local.workspaces : k => v
    if local.workspaces[k].create_app_hello == true
  }
  agent_pool          = module.tfc_agent_pool.tfc_agent_pool
  auto_apply          = each.value.auto_apply
  description         = "${each.key} App Hello Workspace"
  global_remote_state = true
  name                = "${each.key}_app_hello"
  terraform_version   = var.terraform_version
  tfc_oauth_token     = var.tfc_oauth_token
  tfc_org_name        = var.tfc_organization
  vcs_repo            = var.vcs_repo
  working_directory   = "modules/app_hello"
}

output "app_workspaces" {
  description = "Terraform Cloud App Hello Workspace IDs and Names."
  value       = { for v in sort(keys(module.app_workspaces)) : v => module.app_workspaces[v] }
}


#__________________________________________________________
#
# Intersight Workload Optimizer Workspaces
#__________________________________________________________

module "iwo_workspaces" {
  source              = "terraform-cisco-modules/modules/tfe//modules/tfc_workspace"
  for_each = {
    for k, v in local.workspaces : k => v
    if local.workspaces[k].create_iwo == true
  }
  auto_apply          = each.value.auto_apply
  description         = "${each.key} IWO Workspace"
  global_remote_state = true
  name                = "${each.key}_iwo"
  terraform_version   = var.terraform_version
  tfc_oauth_token     = var.tfc_oauth_token
  tfc_org_name        = var.tfc_organization
  vcs_repo            = var.vcs_repo
  working_directory   = "modules/iwo"
}

output "iwo_workspaces" {
  description = "Terraform Cloud IWO Workspace IDs and Names."
  value       = { for v in sort(keys(module.iwo_workspaces)) : v => module.iwo_workspaces[v] }
}


module "kubeconfig_workspaces" {
  source              = "terraform-cisco-modules/modules/tfe//modules/tfc_workspace"
  for_each = {
    for k, v in local.workspaces : k => v
    if local.workspaces[k].workspace_type == "iks"
  }
  auto_apply          = each.value.auto_apply
  description         = "${each.key} kubeconfig Workspace"
  global_remote_state = true
  name                = "${each.key}_kubeconfig"
  terraform_version   = var.terraform_version
  tfc_oauth_token     = var.tfc_oauth_token
  tfc_org_name        = var.tfc_organization
  vcs_repo            = var.vcs_repo
  working_directory   = "modules/kubeconfig"
}

output "kubeconfig_workspaces" {
  description = "Terraform Cloud kubeconfig Workspace IDs and Names."
  value       = { for v in sort(keys(module.kubeconfig_workspaces)) : v => module.kubeconfig_workspaces[v] }
}


#__________________________________________________________
#
# IKS and Kubernetes Policies Workspaces
#__________________________________________________________

module "workspaces" {
  source              = "terraform-cisco-modules/modules/tfe//modules/tfc_workspace"
  for_each            = local.workspaces
  # agent_pool          = each.value.workspace_type == "app" ? module.tfc_agent_pool.tfc_agent_pool : null
  auto_apply          = each.value.auto_apply
  description         = each.value.description
  global_remote_state = each.value.remote_state
  name                = each.key
  terraform_version   = var.terraform_version
  tfc_oauth_token     = var.tfc_oauth_token
  tfc_org_name        = var.tfc_organization
  vcs_repo            = var.vcs_repo
  working_directory   = each.value.working_directory
}

output "workspaces" {
  description = "Terraform Cloud Workspace IDs and Names."
  value       = { for v in sort(keys(module.workspaces)) : v => module.workspaces[v] }
}


#__________________________________________________________
#
# Intersight Variables
#__________________________________________________________

module "intersight_global_variables" {
  source = "terraform-cisco-modules/modules/tfe//modules/tfc_variables"
  depends_on = [
    module.workspaces
  ]
  for_each = local.workspaces
  category     = "terraform"
  workspace_id = module.workspaces[each.key].workspace.id
  variable_list = {
    apikey = {
      description = "Intersight API Key."
      key         = "apikey"
      sensitive   = true
      value       = var.apikey
    },
    endpoint = {
      description = "Intersight Endpoint."
      key         = "endpoint"
      value       = var.endpoint
    },
    organizations = {
      description = "Intersight Organizations."
      key         = "organizations"
      value       = "${jsonencode(var.organizations)}"
    },
    secretkey = {
      description = "Intersight Secret Key."
      key         = "secretkey"
      sensitive   = true
      value       = var.secretkey
    },
  }
}


#__________________________________________________________
#
# Kubernetes Policies Variables
#__________________________________________________________

module "k8s_policies_variables" {
  source = "terraform-cisco-modules/modules/tfe//modules/tfc_variables"
  depends_on = [
    module.workspaces
  ]
  for_each = {
    for k, v in local.workspaces : k => v
    if local.workspaces[k].workspace_type == "k8s_policies"
  }
  category     = "terraform"
  workspace_id = module.workspaces[each.key].workspace.id
  variable_list = {
    tags = {
      description = "Intersight Tags for Poliices and Profiles."
      hcl         = false
      key         = "tags"
      value       = "${jsonencode(var.tags)}"
    },
    ip_pools = {
      description = "IP Pools."
      hcl         = false
      key         = "ip_pools"
      value       = "${jsonencode(var.ip_pools)}"
    },
    k8s_addon_policies = {
      description = "Addons Policies."
      hcl         = false
      key         = "k8s_addon_policies"
      value       = "${jsonencode(var.k8s_addon_policies)}"
    },
    k8s_network_cidr = {
      description = "Kubernetes Network CIDR Policy Variables."
      hcl         = false
      key         = "k8s_network_cidr"
      value       = "${jsonencode(var.k8s_network_cidr)}"
    },
    k8s_nodeos_config = {
      description = "Kubernetes Node OS Configuration Policy Variables."
      hcl         = false
      key         = "k8s_nodeos_config"
      value       = "${jsonencode(var.k8s_nodeos_config)}"
    },
    k8s_runtime_create = {
      description = "Kubernetes Runtime Policy Create Option."
      key         = "k8s_runtime_create"
      value       = var.k8s_runtime_create
    },
    k8s_runtime_policies = {
      description = "Kubernetes Runtime Policy Variables."
      hcl         = false
      key         = "k8s_runtime_policies"
      value       = "${jsonencode(var.k8s_runtime_policies)}"
    },
    k8s_trusted_create = {
      description = "Kubernetes Trusted Registry Policy Create Option."
      key         = "k8s_trusted_create"
      value       = var.k8s_trusted_create
    },
    k8s_trusted_registries = {
      description = "Kubernetes Trusted Registry Policy Variables."
      hcl         = false
      key         = "k8s_trusted_registries"
      value       = "${jsonencode(var.k8s_trusted_registries)}"
    },
    k8s_version_policies = {
      description = "Kubernetes Version Policy Variables."
      hcl         = false
      key         = "k8s_version_policies"
      value       = "${jsonencode(var.k8s_version_policies)}"
    },
    k8s_vm_infra_config = {
      description = "Kubernetes VIrtual Machine Infra Config Policy Variables."
      hcl         = false
      key         = "k8s_vm_infra_config"
      value       = "${jsonencode(var.k8s_vm_infra_config)}"
    },
    k8s_vm_infra_password = {
      description = "VIrtual Center Password."
      key         = "k8s_vm_infra_password"
      sensitive   = true
      value       = var.k8s_vm_infra_password
    }
    k8s_vm_instance_type = {
      description = "Kubernetes Virtual Machine Instance Policy Variables."
      hcl         = false
      key         = "k8s_vm_instance_type"
      value       = "${jsonencode(var.k8s_vm_instance_type)}"
    }
  }
}


#__________________________________________________________
#
# Intersight Kubernetes Service Variables
#__________________________________________________________

module "iks_variables" {
  source = "terraform-cisco-modules/modules/tfe//modules/tfc_variables"
  depends_on = [
    module.workspaces
  ]
  for_each = {
    for k, v in local.workspaces : k => v
    if local.workspaces[k].workspace_type == "iks"
  }
  category     = "terraform"
  workspace_id = module.workspaces[each.key].workspace.id
  variable_list = {
    #---------------------------
    # Terraform Cloud Variables
    #---------------------------
    tfc_organization = {
      description = "Terraform Cloud Organization."
      key         = "tfc_organization"
      value       = var.tfc_organization
    },
    #---------------------------
    # IKS Cluster Variables
    #---------------------------
    iks_cluster = {
      description = each.value.cluster_name != "" ? "${each.value.cluster_name} IKS Cluster." : "${each.key} IKS Cluster."
      hcl         = false
      key         = "iks_cluster"
      value       = each.value.cluster_name != "" ? "{ \"${each.value.cluster_name}\": ${jsonencode(local.iks_cluster[each.value.cluster_name])} }" : "{ \"${each.key}\": ${jsonencode(local.iks_cluster[each.key])} }"
    },
    ssh_key_1 = {
      description = "SSH Key Variable 1."
      key         = "ssh_key_1"
      sensitive   = true
      value       = var.ssh_key_1
    },
    ssh_key_2 = {
      description = "SSH Key Variable 2."
      key         = "ssh_key_2"
      sensitive   = true
      value       = var.ssh_key_2
    },
    ssh_key_3 = {
      description = "SSH Key Variable 3."
      key         = "ssh_key_3"
      sensitive   = true
      value       = var.ssh_key_3
    },
    ssh_key_4 = {
      description = "SSH Key Variable 4."
      key         = "ssh_key_4"
      sensitive   = true
      value       = var.ssh_key_4
    },
    ssh_key_5 = {
      description = "SSH Key Variable 5."
      key         = "ssh_key_5"
      sensitive   = true
      value       = var.ssh_key_5
    },
  }
}


#__________________________________________________________
#
# Intersight Kubernetes Service - app_hello Variables
#__________________________________________________________

module "app_variables" {
  source = "terraform-cisco-modules/modules/tfe//modules/tfc_variables"
  depends_on = [
    module.app_workspaces
  ]
  for_each = {
    for k, v in local.workspaces : k => v
    if local.workspaces[k].workspace_type == "iks"
  }
  category     = "terraform"
  workspace_id = module.app_workspaces[each.key].workspace.id
  variable_list = {
    tfc_organization = {
      description = "Terraform Cloud Organization."
      key         = "tfc_organization"
      value       = var.tfc_organization
    },
    tfc_workspace = {
      description = "${each.key}_kubeconfig Workspace."
      key         = "ws_kubeconfig"
      value       = "${each.key}_kubeconfig"
    }
  }
}


#__________________________________________________________
#
# Intersight Kubernetes Service - iwo Variables
#__________________________________________________________

module "iwo_variables" {
  source = "terraform-cisco-modules/modules/tfe//modules/tfc_variables"
  depends_on = [
    module.iwo_workspaces
  ]
  for_each = {
    for k, v in local.workspaces : k => v
    if local.workspaces[k].workspace_type == "iks"
  }
  category     = "terraform"
  workspace_id = module.iwo_workspaces[each.key].workspace.id
  variable_list = {
    tfc_organization = {
      description = "Terraform Cloud Organization."
      key         = "tfc_organization"
      value       = var.tfc_organization
    },
    tfc_workspace = {
      description = "${each.key}_kubeconfig Workspace."
      key         = "ws_kubeconfig"
      value       = "${each.key}_kubeconfig"
    }
  }
}


#__________________________________________________________
#
# Intersight Kubernetes Service - kubeconfig Variables
#__________________________________________________________

module "kubeconfig_variables" {
  source = "terraform-cisco-modules/modules/tfe//modules/tfc_variables"
  depends_on = [
    module.kubeconfig_workspaces
  ]
  for_each = {
    for k, v in local.workspaces : k => v
    if local.workspaces[k].workspace_type == "iks"
  }
  category     = "terraform"
  workspace_id = module.kubeconfig_workspaces[each.key].workspace.id
  variable_list = {
    #---------------------------
    # Cluster Variables
    #---------------------------
    cluster_name = {
      description = each.value.cluster_name != "" ? "${each.value.cluster_name} IKS Cluster." : "${each.key} IKS Cluster."
      key         = "cluster_name"
      value       = each.value.cluster_name != "" ? each.value.cluster_name : each.key
    },
  }
}

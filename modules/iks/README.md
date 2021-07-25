# IKS Policies and Cluster Profile Module

## Use this module to create Kubernetes policies and an IKS Cluster profile in Intersight

Run the plan from the Terraform cloud workspace.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_intersight"></a> [intersight](#requirement\_intersight) | 1.0.11 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_intersight"></a> [intersight](#provider\_intersight) | 1.0.11 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_control_plane_instance_type"></a> [control\_plane\_instance\_type](#module\_control\_plane\_instance\_type) | terraform-cisco-modules/iks/intersight//modules/infra_provider | n/a |
| <a name="module_control_plane_profile"></a> [control\_plane\_profile](#module\_control\_plane\_profile) | terraform-cisco-modules/imm/intersight//modules/k8s_node_profile | n/a |
| <a name="module_iks_cluster"></a> [iks\_cluster](#module\_iks\_cluster) | terraform-cisco-modules/imm/intersight//modules/k8s_cluster | n/a |
| <a name="module_ip_pools"></a> [ip\_pools](#module\_ip\_pools) | terraform-cisco-modules/imm/intersight//modules/pools_ip | n/a |
| <a name="module_k8s_addons"></a> [k8s\_addons](#module\_k8s\_addons) | terraform-cisco-modules/imm/intersight//modules/policies_k8s_addons | n/a |
| <a name="module_k8s_runtime_policies"></a> [k8s\_runtime\_policies](#module\_k8s\_runtime\_policies) | terraform-cisco-modules/iks/intersight//modules/runtime_policy | n/a |
| <a name="module_k8s_trusted_registries"></a> [k8s\_trusted\_registries](#module\_k8s\_trusted\_registries) | terraform-cisco-modules/iks/intersight//modules/trusted_registry | n/a |
| <a name="module_k8s_version_policies"></a> [k8s\_version\_policies](#module\_k8s\_version\_policies) | terraform-cisco-modules/iks/intersight//modules/version | n/a |
| <a name="module_k8s_vm_infra_policies"></a> [k8s\_vm\_infra\_policies](#module\_k8s\_vm\_infra\_policies) | terraform-cisco-modules/imm/intersight//modules/policies_k8s_vm_infra | n/a |
| <a name="module_k8s_vm_instance"></a> [k8s\_vm\_instance](#module\_k8s\_vm\_instance) | terraform-cisco-modules/iks/intersight//modules/worker_profile | n/a |
| <a name="module_k8s_vm_network_policy"></a> [k8s\_vm\_network\_policy](#module\_k8s\_vm\_network\_policy) | terraform-cisco-modules/iks/intersight//modules/k8s_network | n/a |
| <a name="module_worker_instance_type"></a> [worker\_instance\_type](#module\_worker\_instance\_type) | terraform-cisco-modules/iks/intersight//modules/infra_provider | n/a |
| <a name="module_worker_profile"></a> [worker\_profile](#module\_worker\_profile) | terraform-cisco-modules/imm/intersight//modules/k8s_node_profile | n/a |

## Resources

| Name | Type |
|------|------|
| [intersight_organization_organization.org_moid](https://registry.terraform.io/providers/CiscoDevNet/intersight/1.0.11/docs/data-sources/organization_organization) | data source |
| [intersight_organization_organization.organization_moid](https://registry.terraform.io/providers/CiscoDevNet/intersight/1.0.11/docs/data-sources/organization_organization) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_apikey"></a> [apikey](#input\_apikey) | Intersight API Key. | `string` | n/a | yes |
| <a name="input_dns_servers_v4"></a> [dns\_servers\_v4](#input\_dns\_servers\_v4) | DNS Servers for Kubernetes Sysconfig Policy. | `list(string)` | <pre>[<br>  "198.18.0.100",<br>  "198.18.0.101"<br>]</pre> | no |
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | Domain Name for Kubernetes Sysconfig Policy. | `string` | `"example.com"` | no |
| <a name="input_endpoint"></a> [endpoint](#input\_endpoint) | Intersight URL. | `string` | `"https://intersight.com"` | no |
| <a name="input_iks_cluster"></a> [iks\_cluster](#input\_iks\_cluster) | Action to perform on the Intersight Kubernetes Cluster.  Options are {Delete\|Deploy\|Ready\|No-op\|Unassign}. | <pre>map(object(<br>    {<br>      action_cluster             = optional(string)<br>      action_control_plane       = optional(string)<br>      action_worker              = optional(string)<br>      action                     = optional(string)<br>      addons                     = optional(set(string))<br>      control_plane_desired_size = optional(number)<br>      control_plane_intance_moid = string<br>      control_plane_max_size     = optional(number)<br>      ip_pool_moid               = string<br>      k8s_vm_infra_moid          = string<br>      load_balancers             = optional(number)<br>      ssh_key                    = string<br>      ssh_user                   = string<br>      registry_moid              = optional(string)<br>      runtime_moid               = optional(list(map(string)))<br>      tags                       = optional(list(map(string)))<br>      version_moid               = string<br>      vm_network_moid            = string<br>      wait_for_complete          = optional(bool)<br>      worker_desired_size        = optional(number)<br>      worker_intance_moid        = string<br>      worker_max_size            = optional(number)<br>    }<br>  ))</pre> | <pre>{<br>  "default": {<br>    "action_cluster": "Deploy",<br>    "action_control_plane": "No-op",<br>    "action_worker": "No-op",<br>    "addons": [],<br>    "control_plane_desired_size": 1,<br>    "control_plane_intance_moid": "**REQUIRED**",<br>    "control_plane_max_size": 3,<br>    "ip_pool_moid": "**REQUIRED**",<br>    "k8s_vm_infra_moid": "**REQUIRED**",<br>    "load_balancers": 3,<br>    "registry_moid": "",<br>    "runtime_moid": [],<br>    "ssh_key": "ssh_key_1",<br>    "ssh_user": "iksadmin",<br>    "tags": [],<br>    "version_moid": "**REQUIRED**",<br>    "vm_network_moid": "**REQUIRED**",<br>    "wait_for_complete": false,<br>    "worker_desired_size": 0,<br>    "worker_intance_moid": "**REQUIRED**",<br>    "worker_max_size": 4<br>  }<br>}</pre> | no |
| <a name="input_ip_pools"></a> [ip\_pools](#input\_ip\_pools) | * from - host address of the pool starting address.  Default is 20<br>* gateway - ip/prefix of the gateway.  Default is 198.18.0.1/24<br>* name - Name of the IP Pool.  Default is {tenant}\_{cluster\_name}\_ip\_pool.<br>* size - Number of host addresses to assign to the pool.  Default is 30. | <pre>map(object(<br>    {<br>      from    = optional(number)<br>      gateway = optional(string)<br>      name    = optional(string)<br>      size    = optional(number)<br>      tags    = optional(list(map(string)))<br>    }<br>  ))</pre> | <pre>{<br>  "default": {<br>    "from": 20,<br>    "gateway": "198.18.0.1/24",<br>    "name": "{tenant_name}_ip_pool",<br>    "size": 30,<br>    "tags": []<br>  }<br>}</pre> | no |
| <a name="input_k8s_addons"></a> [k8s\_addons](#input\_k8s\_addons) | Map of Add-ons for Intersight Kubernetes Service.  Add-ons Options are {ccp-monitor\|kubernetes-dashboard}. | <pre>map(object(<br>    {<br>      install_strategy = optional(string)<br>      name             = optional(string)<br>      release_name     = optional(string)<br>      tags             = optional(list(map(string)))<br>      upgrade_strategy = optional(string)<br>    }<br>  ))</pre> | <pre>{<br>  "default": {<br>    "install_strategy": "Always",<br>    "name": "{tenant_name}_{addon_key}",<br>    "release_name": "",<br>    "tags": [],<br>    "upgrade_strategy": "UpgradeOnly"<br>  }<br>}</pre> | no |
| <a name="input_k8s_runtime"></a> [k8s\_runtime](#input\_k8s\_runtime) | n/a | <pre>map(object(<br>    {<br>      docker_bridge_cidr = optional(string)<br>      docker_no_proxy    = optional(list(string))<br>      http_hostname      = optional(string)<br>      http_port          = optional(number)<br>      http_protocol      = optional(string)<br>      http_username      = optional(string)<br>      https_hostname     = optional(string)<br>      https_port         = optional(number)<br>      https_protocol     = optional(string)<br>      https_username     = optional(string)<br>      name               = optional(string)<br>      tags               = optional(list(map(string)))<br>    }<br>  ))</pre> | <pre>{<br>  "default": {<br>    "docker_bridge_cidr": "",<br>    "docker_no_proxy": [],<br>    "http_hostname": "",<br>    "http_port": 8080,<br>    "http_protocol": "http",<br>    "http_username": "",<br>    "https_hostname": "",<br>    "https_port": 8443,<br>    "https_protocol": "https",<br>    "https_username": "",<br>    "name": "",<br>    "tags": []<br>  }<br>}</pre> | no |
| <a name="input_k8s_runtime_create"></a> [k8s\_runtime\_create](#input\_k8s\_runtime\_create) | Flag to specify if the Kubernetes Runtime Policy should be created or not. | `bool` | `false` | no |
| <a name="input_k8s_runtime_http_password"></a> [k8s\_runtime\_http\_password](#input\_k8s\_runtime\_http\_password) | Password for the HTTP Proxy Server, If required. | `string` | `""` | no |
| <a name="input_k8s_runtime_https_password"></a> [k8s\_runtime\_https\_password](#input\_k8s\_runtime\_https\_password) | Password for the HTTPS Proxy Server, If required. | `string` | `""` | no |
| <a name="input_k8s_trusted_create"></a> [k8s\_trusted\_create](#input\_k8s\_trusted\_create) | Flag to specify if the Kubernetes Runtime Policy should be created or not. | `bool` | `false` | no |
| <a name="input_k8s_trusted_registry"></a> [k8s\_trusted\_registry](#input\_k8s\_trusted\_registry) | n/a | <pre>map(object(<br>    {<br>      name     = optional(string)<br>      root_ca  = optional(list(string))<br>      tags     = optional(list(map(string)))<br>      unsigned = optional(list(string))<br>    }<br>  ))</pre> | <pre>{<br>  "default": {<br>    "name": "",<br>    "root_ca": [],<br>    "tags": [],<br>    "unsigned": []<br>  }<br>}</pre> | no |
| <a name="input_k8s_version"></a> [k8s\_version](#input\_k8s\_version) | Kubernetes Version to Deploy. | <pre>map(object(<br>    {<br>      name    = optional(string)<br>      tags    = optional(list(map(string)))<br>      version = optional(string)<br>    }<br>  ))</pre> | <pre>{<br>  "default": {<br>    "name": "",<br>    "tags": [],<br>    "version": "1.19.5"<br>  }<br>}</pre> | no |
| <a name="input_k8s_vm_infra"></a> [k8s\_vm\_infra](#input\_k8s\_vm\_infra) | Kubernetes Virtual Machine Infrastructure Configuration Policy.  Default name is {tenant\_name}\_vm\_infra. | <pre>map(object(<br>    {<br>      name                  = optional(string)<br>      tags                  = optional(list(map(string)))<br>      vsphere_cluster       = string<br>      vsphere_datastore     = string<br>      vsphere_portgroup     = list(string)<br>      vsphere_resource_pool = optional(string)<br>      vsphere_target        = string<br>    }<br>  ))</pre> | <pre>{<br>  "default": {<br>    "name": "",<br>    "tags": [],<br>    "vsphere_cluster": "default",<br>    "vsphere_datastore": "datastore1",<br>    "vsphere_portgroup": [<br>      "VM Network"<br>    ],<br>    "vsphere_resource_pool": "",<br>    "vsphere_target": ""<br>  }<br>}</pre> | no |
| <a name="input_k8s_vm_infra_password"></a> [k8s\_vm\_infra\_password](#input\_k8s\_vm\_infra\_password) | vSphere Password.  Note: this is the password of the Credentials used to register the vSphere Target. | `string` | n/a | yes |
| <a name="input_k8s_vm_instance"></a> [k8s\_vm\_instance](#input\_k8s\_vm\_instance) | Kubernetes Virtual Machine Instance Policy Variables.  Default name is {tenant\_name}\_vm\_network. | <pre>map(object(<br>    {<br>      cpu    = optional(number)<br>      disk   = optional(number)<br>      memory = optional(number)<br>      tags   = optional(list(map(string)))<br>    }<br>  ))</pre> | <pre>{<br>  "default": {<br>    "cpu": 4,<br>    "disk": 40,<br>    "memory": 16384,<br>    "tags": []<br>  }<br>}</pre> | no |
| <a name="input_k8s_vm_network"></a> [k8s\_vm\_network](#input\_k8s\_vm\_network) | Kubernetes Virtual Machine Network Configuration Policy.  Default name is {tenant\_name}\_vm\_network. | <pre>map(object(<br>    {<br>      cidr_pod     = optional(string)<br>      cidr_service = optional(string)<br>      cni          = optional(string)<br>      name         = optional(string)<br>      tags         = optional(list(map(string)))<br>    }<br>  ))</pre> | <pre>{<br>  "default": {<br>    "cidr_pod": "100.64.0.0/16",<br>    "cidr_service": "100.65.0.0/16",<br>    "cni": "Calico",<br>    "name": "",<br>    "tags": []<br>  }<br>}</pre> | no |
| <a name="input_ntp_servers"></a> [ntp\_servers](#input\_ntp\_servers) | NTP Servers for Kubernetes Sysconfig Policy. | `list(string)` | `[]` | no |
| <a name="input_organization"></a> [organization](#input\_organization) | Intersight Organization. | `string` | `"default"` | no |
| <a name="input_secretkey"></a> [secretkey](#input\_secretkey) | Intersight Secret Key. | `string` | n/a | yes |
| <a name="input_ssh_key_1"></a> [ssh\_key\_1](#input\_ssh\_key\_1) | Intersight Kubernetes Service Cluster SSH Public Key 1. | `string` | `""` | no |
| <a name="input_ssh_key_2"></a> [ssh\_key\_2](#input\_ssh\_key\_2) | Intersight Kubernetes Service Cluster SSH Public Key 2.  These are place holders for Tenants that use different keys for different clusters. | `string` | `""` | no |
| <a name="input_ssh_key_3"></a> [ssh\_key\_3](#input\_ssh\_key\_3) | Intersight Kubernetes Service Cluster SSH Public Key 3.  These are place holders for Tenants that use different keys for different clusters. | `string` | `""` | no |
| <a name="input_ssh_key_4"></a> [ssh\_key\_4](#input\_ssh\_key\_4) | Intersight Kubernetes Service Cluster SSH Public Key 4.  These are place holders for Tenants that use different keys for different clusters. | `string` | `""` | no |
| <a name="input_ssh_key_5"></a> [ssh\_key\_5](#input\_ssh\_key\_5) | Intersight Kubernetes Service Cluster SSH Public Key 5.  These are place holders for Tenants that use different keys for different clusters. | `string` | `""` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to be Associated with Objects Created in Intersight. | `list(map(string))` | `[]` | no |
| <a name="input_tenant_name"></a> [tenant\_name](#input\_tenant\_name) | Name of the Tenant. | `string` | `"default"` | no |
| <a name="input_timezone"></a> [timezone](#input\_timezone) | Timezone for Kubernetes Sysconfig Policy. | `string` | `"Etc/GMT"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_endpoint"></a> [endpoint](#output\_endpoint) | Intersight URL. |
| <a name="output_iks_cluster"></a> [iks\_cluster](#output\_iks\_cluster) | moid of the IKS Cluster. |
| <a name="output_ip_pools"></a> [ip\_pools](#output\_ip\_pools) | moid of the IP Pool |
| <a name="output_k8s_addons"></a> [k8s\_addons](#output\_k8s\_addons) | moid of the Kubernetes CIDR Policies. |
| <a name="output_k8s_network_cidr"></a> [k8s\_network\_cidr](#output\_k8s\_network\_cidr) | moid of the Kubernetes CIDR Policies. |
| <a name="output_k8s_nodeos_config"></a> [k8s\_nodeos\_config](#output\_k8s\_nodeos\_config) | moid of the Kubernetes Node OS Config Policies. |
| <a name="output_k8s_runtime_policies"></a> [k8s\_runtime\_policies](#output\_k8s\_runtime\_policies) | moid of the Kubernetes Runtime Policy. |
| <a name="output_k8s_trusted_registries"></a> [k8s\_trusted\_registries](#output\_k8s\_trusted\_registries) | moid of the Kubernetes Trusted Registry Policy. |
| <a name="output_k8s_version_policies"></a> [k8s\_version\_policies](#output\_k8s\_version\_policies) | moid of the Kubernetes Version Policies. |
| <a name="output_k8s_vm_infra_policies"></a> [k8s\_vm\_infra\_policies](#output\_k8s\_vm\_infra\_policies) | moid of the Kubernetes VM Infrastructure Policies. |
| <a name="output_k8s_vm_instance"></a> [k8s\_vm\_instance](#output\_k8s\_vm\_instance) | moid of the Large Kubernetes Instance Type Policies. |
| <a name="output_org_moid"></a> [org\_moid](#output\_org\_moid) | moid of the Intersight Organization. |
| <a name="output_organization"></a> [organization](#output\_organization) | Intersight Organization Name. |
| <a name="output_tags"></a> [tags](#output\_tags) | Tags to be Associated with Objects Created in Intersight. |
| <a name="output_tenant_name"></a> [tenant\_name](#output\_tenant\_name) | Name of the Tenant. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

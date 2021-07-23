# Global Variables Workspace

## Use this module to create Global Variales consumed by the IKS workspaces

Run the plan from the Terraform cloud workspace for the Given Workspace.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_intersight"></a> [intersight](#requirement\_intersight) | >=1.0.11 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_intersight"></a> [intersight](#provider\_intersight) | 1.0.12 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_ip_pools"></a> [ip\_pools](#module\_ip\_pools) | terraform-cisco-modules/imm/intersight//modules/pools_ip | n/a |
| <a name="module_k8s_runtime_policy"></a> [k8s\_runtime\_policy](#module\_k8s\_runtime\_policy) | terraform-cisco-modules/iks/intersight//modules/runtime_policy | n/a |
| <a name="module_k8s_trusted_registry"></a> [k8s\_trusted\_registry](#module\_k8s\_trusted\_registry) | terraform-cisco-modules/iks/intersight//modules/trusted_registry | n/a |
| <a name="module_k8s_version_policy"></a> [k8s\_version\_policy](#module\_k8s\_version\_policy) | terraform-cisco-modules/iks/intersight//modules/version | n/a |
| <a name="module_k8s_vm_infra_policy"></a> [k8s\_vm\_infra\_policy](#module\_k8s\_vm\_infra\_policy) | terraform-cisco-modules/iks/intersight//modules/infra_config_policy | n/a |
| <a name="module_k8s_vm_instance_large"></a> [k8s\_vm\_instance\_large](#module\_k8s\_vm\_instance\_large) | terraform-cisco-modules/iks/intersight//modules/worker_profile | n/a |
| <a name="module_k8s_vm_instance_medium"></a> [k8s\_vm\_instance\_medium](#module\_k8s\_vm\_instance\_medium) | terraform-cisco-modules/iks/intersight//modules/worker_profile | n/a |
| <a name="module_k8s_vm_instance_small"></a> [k8s\_vm\_instance\_small](#module\_k8s\_vm\_instance\_small) | terraform-cisco-modules/iks/intersight//modules/worker_profile | n/a |
| <a name="module_k8s_vm_network_policy"></a> [k8s\_vm\_network\_policy](#module\_k8s\_vm\_network\_policy) | terraform-cisco-modules/iks/intersight//modules/k8s_network | n/a |

## Resources

| Name | Type |
|------|------|
| [intersight_organization_organization.org_moid](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/data-sources/organization_organization) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_apikey"></a> [apikey](#input\_apikey) | Intersight API Key. | `string` | n/a | yes |
| <a name="input_dns_servers_v4"></a> [dns\_servers\_v4](#input\_dns\_servers\_v4) | DNS Servers for Kubernetes Sysconfig Policy. | `list(string)` | <pre>[<br>  "198.18.0.100",<br>  "198.18.0.101"<br>]</pre> | no |
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | Domain Name for Kubernetes Sysconfig Policy. | `string` | `"example.com"` | no |
| <a name="input_endpoint"></a> [endpoint](#input\_endpoint) | Intersight URL. | `string` | `"https://intersight.com"` | no |
| <a name="input_ip_pools"></a> [ip\_pools](#input\_ip\_pools) | * from - host address of the pool starting address.  Default is 20<br> * gateway - ip/prefix of the gateway.  Default is 198.18.0.1/24<br> * name - Name of the IP Pool.  Default is {tenant}\_{cluster\_name}\_ip\_pool.<br> * size - Number of host addresses to assign to the pool.  Default is 30. | <pre>map(object(<br>    {<br>      from    = optional(number)<br>      gateway = optional(string)<br>      name    = optional(string)<br>      size    = optional(number)<br>      tags    = optional(list(map(string)))<br>    }<br>  ))</pre> | <pre>{<br>  "default": {<br>    "from": 20,<br>    "gateway": "198.18.0.1/24",<br>    "name": "{tenant_name}_ip_pool",<br>    "size": 30,<br>    "tags": []<br>  }<br>}</pre> | no |
| <a name="input_k8s_runtime"></a> [k8s\_runtime](#input\_k8s\_runtime) | n/a | <pre>object(<br>    {<br>      docker_bridge_cidr = optional(string)<br>      docker_no_proxy    = optional(list(string))<br>      http_hostname      = optional(string)<br>      http_port          = optional(number)<br>      http_protocol      = optional(string)<br>      http_username      = optional(string)<br>      https_hostname     = optional(string)<br>      https_port         = optional(number)<br>      https_protocol     = optional(string)<br>      https_username     = optional(string)<br>      name               = optional(string)<br>      tags               = optional(list(map(string)))<br>    }<br>  )</pre> | <pre>{<br>  "docker_bridge_cidr": "",<br>  "docker_no_proxy": [],<br>  "http_hostname": "",<br>  "http_port": 8080,<br>  "http_protocol": "http",<br>  "http_username": "",<br>  "https_hostname": "",<br>  "https_port": 8443,<br>  "https_protocol": "https",<br>  "https_username": "",<br>  "name": "",<br>  "tags": []<br>}</pre> | no |
| <a name="input_k8s_runtime_http_password"></a> [k8s\_runtime\_http\_password](#input\_k8s\_runtime\_http\_password) | Password for the HTTP Proxy Server, If required. | `string` | `""` | no |
| <a name="input_k8s_runtime_https_password"></a> [k8s\_runtime\_https\_password](#input\_k8s\_runtime\_https\_password) | Password for the HTTPS Proxy Server, If required. | `string` | `""` | no |
| <a name="input_k8s_trusted_registry"></a> [k8s\_trusted\_registry](#input\_k8s\_trusted\_registry) | n/a | <pre>object(<br>    {<br>      name     = optional(string)<br>      root_ca  = optional(list(string))<br>      tags     = optional(list(map(string)))<br>      unsigned = optional(list(string))<br>    }<br>  )</pre> | <pre>{<br>  "name": "",<br>  "root_ca": [],<br>  "tags": [],<br>  "unsigned": []<br>}</pre> | no |
| <a name="input_k8s_version"></a> [k8s\_version](#input\_k8s\_version) | n/a | <pre>map(object(<br>    {<br>      name    = optional(string)<br>      tags    = optional(list(map(string)))<br>      version = optional(string)<br>    }<br>  ))</pre> | <pre>{<br>  "default": {<br>    "name": "",<br>    "tags": [],<br>    "version": "1.19.5"<br>  }<br>}</pre> | no |
| <a name="input_k8s_vm_infra"></a> [k8s\_vm\_infra](#input\_k8s\_vm\_infra) | Kubernetes Virtual Machine Infrastructure Configuration Policy.  Default name is {tenant\_name}\_vm\_infra. | <pre>map(object(<br>    {<br>      name                  = optional(string)<br>      tags                  = optional(list(map(string)))<br>      vsphere_cluster       = string<br>      vsphere_datastore     = string<br>      vsphere_portgroup     = list(string)<br>      vsphere_resource_pool = optional(string)<br>      vsphere_target        = string<br>    }<br>  ))</pre> | <pre>{<br>  "default": {<br>    "name": "",<br>    "tags": [],<br>    "vsphere_cluster": "default",<br>    "vsphere_datastore": "datastore1",<br>    "vsphere_portgroup": [<br>      "VM Network"<br>    ],<br>    "vsphere_resource_pool": "",<br>    "vsphere_target": ""<br>  }<br>}</pre> | no |
| <a name="input_k8s_vm_infra_password"></a> [k8s\_vm\_infra\_password](#input\_k8s\_vm\_infra\_password) | vSphere Password.  Note: this is the password of the Credentials used to register the vSphere Target. | `string` | n/a | yes |
| <a name="input_k8s_vm_instance"></a> [k8s\_vm\_instance](#input\_k8s\_vm\_instance) | Kubernetes Virtual Machine Instance Policy Variables.  Default name is {tenant\_name}\_vm\_network. | <pre>map(object(<br>    {<br>      large_cpu     = optional(number)<br>      large_disk    = optional(number)<br>      large_memory  = optional(number)<br>      medium_cpu    = optional(number)<br>      medium_disk   = optional(number)<br>      medium_memory = optional(number)<br>      small_cpu     = optional(number)<br>      small_disk    = optional(number)<br>      small_memory  = optional(number)<br>      tags          = optional(list(map(string)))<br>    }<br>  ))</pre> | <pre>{<br>  "default": {<br>    "large_cpu": 12,<br>    "large_disk": 80,<br>    "large_memory": 32768,<br>    "medium_cpu": 8,<br>    "medium_disk": 60,<br>    "medium_memory": 24576,<br>    "small_cpu": 4,<br>    "small_disk": 40,<br>    "small_memory": 16384,<br>    "tags": []<br>  }<br>}</pre> | no |
| <a name="input_k8s_vm_network"></a> [k8s\_vm\_network](#input\_k8s\_vm\_network) | Kubernetes Virtual Machine Network Configuration Policy.  Default name is {tenant\_name}\_vm\_network. | <pre>map(object(<br>    {<br>      cidr_pod     = optional(string)<br>      cidr_service = optional(string)<br>      cni          = optional(string)<br>      name         = optional(string)<br>      tags         = optional(list(map(string)))<br>    }<br>  ))</pre> | <pre>{<br>  "default": {<br>    "cidr_pod": "100.64.0.0/16",<br>    "cidr_service": "100.65.0.0/16",<br>    "cni": "Calico",<br>    "name": "",<br>    "tags": []<br>  }<br>}</pre> | no |
| <a name="input_ntp_servers"></a> [ntp\_servers](#input\_ntp\_servers) | NTP Servers for Kubernetes Sysconfig Policy. | `list(string)` | `[]` | no |
| <a name="input_organization"></a> [organization](#input\_organization) | Intersight Organization. | `string` | `"default"` | no |
| <a name="input_secretkey"></a> [secretkey](#input\_secretkey) | Intersight Secret Key. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to be Associated with Objects Created in Intersight. | `list(map(string))` | `[]` | no |
| <a name="input_tenant_name"></a> [tenant\_name](#input\_tenant\_name) | Name of the Tenant. | `string` | `"default"` | no |
| <a name="input_timezone"></a> [timezone](#input\_timezone) | Timezone for Kubernetes Sysconfig Policy. | `string` | `"Etc/GMT"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_endpoint"></a> [endpoint](#output\_endpoint) | Intersight URL. |
| <a name="output_ip_pools"></a> [ip\_pools](#output\_ip\_pools) | moid of the IP Pool |
| <a name="output_k8s_network_cidr"></a> [k8s\_network\_cidr](#output\_k8s\_network\_cidr) | moid of the Kubernetes CIDR Policy. |
| <a name="output_k8s_nodeos_config"></a> [k8s\_nodeos\_config](#output\_k8s\_nodeos\_config) | moid of the Kubernetes Node OS Config Policy. |
| <a name="output_k8s_version_policy"></a> [k8s\_version\_policy](#output\_k8s\_version\_policy) | moid of the Kubernetes Version Policy. |
| <a name="output_k8s_vm_infra_policy"></a> [k8s\_vm\_infra\_policy](#output\_k8s\_vm\_infra\_policy) | moid of the Kubernetes VM Infrastructure Policy. |
| <a name="output_k8s_vm_instance_large"></a> [k8s\_vm\_instance\_large](#output\_k8s\_vm\_instance\_large) | moid of the Large Kubernetes Instance Type. |
| <a name="output_k8s_vm_instance_medium"></a> [k8s\_vm\_instance\_medium](#output\_k8s\_vm\_instance\_medium) | moid of the Medium Kubernetes Instance Type. |
| <a name="output_k8s_vm_instance_small"></a> [k8s\_vm\_instance\_small](#output\_k8s\_vm\_instance\_small) | moid of the Small Kubernetes Instance Type. |
| <a name="output_organization"></a> [organization](#output\_organization) | Intersight Organization Name. |
| <a name="output_organization_moid"></a> [organization\_moid](#output\_organization\_moid) | moid of the Intersight Organization. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

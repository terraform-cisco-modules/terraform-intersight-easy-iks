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
| <a name="module_control_plane_node_group"></a> [control\_plane\_node\_group](#module\_control\_plane\_node\_group) | terraform-cisco-modules/imm/intersight//modules/k8s_node_group_profile | n/a |
| <a name="module_control_plane_vm_infra_provider"></a> [control\_plane\_vm\_infra\_provider](#module\_control\_plane\_vm\_infra\_provider) | terraform-cisco-modules/imm/intersight//modules/k8s_vm_infra_provider | n/a |
| <a name="module_iks_cluster"></a> [iks\_cluster](#module\_iks\_cluster) | terraform-cisco-modules/imm/intersight//modules/k8s_cluster | n/a |
| <a name="module_ip_pools"></a> [ip\_pools](#module\_ip\_pools) | terraform-cisco-modules/imm/intersight//modules/pools_ip | n/a |
| <a name="module_k8s_addon_policies"></a> [k8s\_addon\_policies](#module\_k8s\_addon\_policies) | terraform-cisco-modules/imm/intersight//modules/policies_k8s_addons | n/a |
| <a name="module_k8s_network_cidr"></a> [k8s\_network\_cidr](#module\_k8s\_network\_cidr) | terraform-cisco-modules/imm/intersight//modules/policies_k8s_network_cidr | n/a |
| <a name="module_k8s_nodeos_config"></a> [k8s\_nodeos\_config](#module\_k8s\_nodeos\_config) | terraform-cisco-modules/imm/intersight//modules/policies_k8s_nodeos_config | n/a |
| <a name="module_k8s_runtime_policies"></a> [k8s\_runtime\_policies](#module\_k8s\_runtime\_policies) | terraform-cisco-modules/imm/intersight//modules/policies_k8s_runtime | n/a |
| <a name="module_k8s_trusted_registries"></a> [k8s\_trusted\_registries](#module\_k8s\_trusted\_registries) | terraform-cisco-modules/imm/intersight//modules/k8s_trusted_registries | n/a |
| <a name="module_k8s_version_policies"></a> [k8s\_version\_policies](#module\_k8s\_version\_policies) | terraform-cisco-modules/imm/intersight//modules/policies_k8s_version | n/a |
| <a name="module_k8s_vm_infra_config"></a> [k8s\_vm\_infra\_config](#module\_k8s\_vm\_infra\_config) | terraform-cisco-modules/imm/intersight//modules/policies_k8s_vm_infra | n/a |
| <a name="module_k8s_vm_instance_type"></a> [k8s\_vm\_instance\_type](#module\_k8s\_vm\_instance\_type) | terraform-cisco-modules/imm/intersight//modules/policies_k8s_vm_instance_type | n/a |
| <a name="module_worker_node_group"></a> [worker\_node\_group](#module\_worker\_node\_group) | terraform-cisco-modules/imm/intersight//modules/k8s_node_group_profile | n/a |
| <a name="module_worker_vm_infra_provider"></a> [worker\_vm\_infra\_provider](#module\_worker\_vm\_infra\_provider) | terraform-cisco-modules/imm/intersight//modules/k8s_vm_infra_provider | n/a |

## Resources

| Name | Type |
|------|------|
| [intersight_organization_organization.org_moid](https://registry.terraform.io/providers/CiscoDevNet/intersight/1.0.11/docs/data-sources/organization_organization) | data source |
| [intersight_organization_organization.organization_moid](https://registry.terraform.io/providers/CiscoDevNet/intersight/1.0.11/docs/data-sources/organization_organization) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_apikey"></a> [apikey](#input\_apikey) | Intersight API Key. | `string` | n/a | yes |
| <a name="input_endpoint"></a> [endpoint](#input\_endpoint) | Intersight URL. | `string` | `"https://intersight.com"` | no |
| <a name="input_iks_cluster"></a> [iks\_cluster](#input\_iks\_cluster) | Please Refer to the k8s\_version variable information in the tfe module.  In the IKS module the variable is accepted as a string from terraform cloud in the terraform.auto.tfvars and extracted using locals. | `string` | n/a | yes |
| <a name="input_ip_pools"></a> [ip\_pools](#input\_ip\_pools) | Please Refer to the ip\_pools variable information in the tfe module.  In the IKS module the variable is accepted as a string from terraform cloud in the terraform.auto.tfvars and extracted using locals. | `string` | n/a | yes |
| <a name="input_k8s_addon_policies"></a> [k8s\_addon\_policies](#input\_k8s\_addon\_policies) | Please Refer to the k8s\_addons variable information in the tfe module.  In the IKS module the variable is accepted as a string from terraform cloud in the terraform.auto.tfvars and extracted using locals. | `string` | n/a | yes |
| <a name="input_k8s_network_cidr"></a> [k8s\_network\_cidr](#input\_k8s\_network\_cidr) | Please Refer to the k8s\_network\_cidr variable information in the tfe module.  In the IKS module the variable is accepted as a string from terraform cloud in the terraform.auto.tfvars and extracted using locals. | `string` | n/a | yes |
| <a name="input_k8s_nodeos_config"></a> [k8s\_nodeos\_config](#input\_k8s\_nodeos\_config) | Please Refer to the k8s\_nodeos\_config variable information in the tfe module.  In the IKS module the variable is accepted as a string from terraform cloud in the terraform.auto.tfvars and extracted using locals. | `string` | n/a | yes |
| <a name="input_k8s_runtime_create"></a> [k8s\_runtime\_create](#input\_k8s\_runtime\_create) | Flag to specify if the Kubernetes Runtime Policy should be created or not. | `bool` | `false` | no |
| <a name="input_k8s_runtime_http_password"></a> [k8s\_runtime\_http\_password](#input\_k8s\_runtime\_http\_password) | Password for the HTTP Proxy Server, If required. | `string` | `""` | no |
| <a name="input_k8s_runtime_https_password"></a> [k8s\_runtime\_https\_password](#input\_k8s\_runtime\_https\_password) | Password for the HTTPS Proxy Server, If required. | `string` | `""` | no |
| <a name="input_k8s_runtime_policies"></a> [k8s\_runtime\_policies](#input\_k8s\_runtime\_policies) | Please Refer to the k8s\_runtime\_policies variable information in the tfe module.  In the IKS module the variable is accepted as a string from terraform cloud in the terraform.auto.tfvars and extracted using locals. | `string` | n/a | yes |
| <a name="input_k8s_trusted_create"></a> [k8s\_trusted\_create](#input\_k8s\_trusted\_create) | Flag to specify if the Kubernetes Runtime Policy should be created or not. | `bool` | `false` | no |
| <a name="input_k8s_trusted_registries"></a> [k8s\_trusted\_registries](#input\_k8s\_trusted\_registries) | Please Refer to the k8s\_trusted\_registries variable information in the tfe module.  In the IKS module the variable is accepted as a string from terraform cloud in the terraform.auto.tfvars and extracted using locals. | `string` | n/a | yes |
| <a name="input_k8s_version_policies"></a> [k8s\_version\_policies](#input\_k8s\_version\_policies) | Please Refer to the k8s\_version\_policies variable information in the tfe module.  In the IKS module the variable is accepted as a string from terraform cloud in the terraform.auto.tfvars and extracted using locals. | `string` | n/a | yes |
| <a name="input_k8s_vm_infra_config"></a> [k8s\_vm\_infra\_config](#input\_k8s\_vm\_infra\_config) | Please Refer to the k8s\_vm\_infra\_config variable information in the tfe module.  In the IKS module the variable is accepted as a string from terraform cloud in the terraform.auto.tfvars and extracted using locals. | `string` | n/a | yes |
| <a name="input_k8s_vm_infra_password"></a> [k8s\_vm\_infra\_password](#input\_k8s\_vm\_infra\_password) | vSphere Password.  Note: this is the password of the Credentials used to register the vSphere Target. | `string` | n/a | yes |
| <a name="input_k8s_vm_instance_type"></a> [k8s\_vm\_instance\_type](#input\_k8s\_vm\_instance\_type) | Please Refer to the k8s\_vm\_instance\_type variable information in the tfe module.  In the IKS module the variable is accepted as a string from terraform cloud in the terraform.auto.tfvars and extracted using locals. | `string` | n/a | yes |
| <a name="input_organization"></a> [organization](#input\_organization) | Intersight Organization. | `string` | `"default"` | no |
| <a name="input_secretkey"></a> [secretkey](#input\_secretkey) | Intersight Secret Key. | `string` | n/a | yes |
| <a name="input_ssh_key_1"></a> [ssh\_key\_1](#input\_ssh\_key\_1) | Intersight Kubernetes Service Cluster SSH Public Key 1. | `string` | `""` | no |
| <a name="input_ssh_key_2"></a> [ssh\_key\_2](#input\_ssh\_key\_2) | Intersight Kubernetes Service Cluster SSH Public Key 2.  These are place holders for Tenants that use different keys for different clusters. | `string` | `""` | no |
| <a name="input_ssh_key_3"></a> [ssh\_key\_3](#input\_ssh\_key\_3) | Intersight Kubernetes Service Cluster SSH Public Key 3.  These are place holders for Tenants that use different keys for different clusters. | `string` | `""` | no |
| <a name="input_ssh_key_4"></a> [ssh\_key\_4](#input\_ssh\_key\_4) | Intersight Kubernetes Service Cluster SSH Public Key 4.  These are place holders for Tenants that use different keys for different clusters. | `string` | `""` | no |
| <a name="input_ssh_key_5"></a> [ssh\_key\_5](#input\_ssh\_key\_5) | Intersight Kubernetes Service Cluster SSH Public Key 5.  These are place holders for Tenants that use different keys for different clusters. | `string` | `""` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Please Refer to the tags variable information in the tfe module.  In the IKS module the variable is accepted as a string from terraform cloud in the terraform.auto.tfvars and extracted using locals. | `string` | n/a | yes |
| <a name="input_tenant_name"></a> [tenant\_name](#input\_tenant\_name) | Name of the Tenant. | `string` | `"default"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_endpoint"></a> [endpoint](#output\_endpoint) | Intersight URL. |
| <a name="output_iks_cluster"></a> [iks\_cluster](#output\_iks\_cluster) | moid of the IKS Cluster. |
| <a name="output_ip_pools"></a> [ip\_pools](#output\_ip\_pools) | moid of the IP Pool |
| <a name="output_k8s_addon_policies"></a> [k8s\_addon\_policies](#output\_k8s\_addon\_policies) | moid of the Kubernetes CIDR Policies. |
| <a name="output_k8s_network_cidr"></a> [k8s\_network\_cidr](#output\_k8s\_network\_cidr) | moid of the Kubernetes CIDR Policies. |
| <a name="output_k8s_nodeos_config"></a> [k8s\_nodeos\_config](#output\_k8s\_nodeos\_config) | moid of the Kubernetes Node OS Config Policies. |
| <a name="output_k8s_runtime_policies"></a> [k8s\_runtime\_policies](#output\_k8s\_runtime\_policies) | moid of the Kubernetes Runtime Policies. |
| <a name="output_k8s_trusted_registries"></a> [k8s\_trusted\_registries](#output\_k8s\_trusted\_registries) | moid of the Kubernetes Trusted Registry Policy. |
| <a name="output_k8s_version_policies"></a> [k8s\_version\_policies](#output\_k8s\_version\_policies) | moid of the Kubernetes Version Policies. |
| <a name="output_k8s_vm_infra_config"></a> [k8s\_vm\_infra\_config](#output\_k8s\_vm\_infra\_config) | moid of the Kubernetes VM Infrastructure Configuration Policies. |
| <a name="output_k8s_vm_instance_type"></a> [k8s\_vm\_instance\_type](#output\_k8s\_vm\_instance\_type) | moid of the Large Kubernetes Instance Type Policies. |
| <a name="output_org_moid"></a> [org\_moid](#output\_org\_moid) | moid of the Intersight Organization. |
| <a name="output_organization"></a> [organization](#output\_organization) | Intersight Organization Name. |
| <a name="output_tags"></a> [tags](#output\_tags) | Tags to be Associated with Objects Created in Intersight. |
| <a name="output_tenant_name"></a> [tenant\_name](#output\_tenant\_name) | Name of the Tenant. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

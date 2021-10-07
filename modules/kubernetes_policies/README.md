# Kubernetes Policies Module

## Use this module to create Kubernetes policies within the Intersight organization

Run the plan from the Terraform cloud workspace.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_intersight"></a> [intersight](#requirement\_intersight) | 1.0.13 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_intersight"></a> [intersight](#provider\_intersight) | 1.0.13 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_addons_policies"></a> [addons\_policies](#module\_addons\_policies) | terraform-cisco-modules/imm/intersight//modules/addons_policies | n/a |
| <a name="module_container_runtime_policies"></a> [container\_runtime\_policies](#module\_container\_runtime\_policies) | terraform-cisco-modules/imm/intersight//modules/container_runtime_policies | n/a |
| <a name="module_ip_pools"></a> [ip\_pools](#module\_ip\_pools) | terraform-cisco-modules/imm/intersight//modules/ip_pools | n/a |
| <a name="module_kubernetes_version_policies"></a> [kubernetes\_version\_policies](#module\_kubernetes\_version\_policies) | terraform-cisco-modules/imm/intersight//modules/kubernetes_version_policies | n/a |
| <a name="module_network_cidr_policies"></a> [network\_cidr\_policies](#module\_network\_cidr\_policies) | terraform-cisco-modules/imm/intersight//modules/network_cidr_policies | n/a |
| <a name="module_nodeos_configuration_policies"></a> [nodeos\_configuration\_policies](#module\_nodeos\_configuration\_policies) | terraform-cisco-modules/imm/intersight//modules/nodeos_configuration_policies | n/a |
| <a name="module_trusted_certificate_authorities"></a> [trusted\_certificate\_authorities](#module\_trusted\_certificate\_authorities) | terraform-cisco-modules/imm/intersight//modules/trusted_certificate_authorities | n/a |
| <a name="module_virtual_machine_infra_config"></a> [virtual\_machine\_infra\_config](#module\_virtual\_machine\_infra\_config) | terraform-cisco-modules/imm/intersight//modules/virtual_machine_infra_config | n/a |
| <a name="module_virtual_machine_instance_type"></a> [virtual\_machine\_instance\_type](#module\_virtual\_machine\_instance\_type) | terraform-cisco-modules/imm/intersight//modules/virtual_machine_instance_type | n/a |

## Resources

| Name | Type |
|------|------|
| [intersight_organization_organization.org_moid](https://registry.terraform.io/providers/CiscoDevNet/intersight/1.0.13/docs/data-sources/organization_organization) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_addons_policies"></a> [addons\_policies](#input\_addons\_policies) | Please Refer to OSS Model Below for Variable Details | `string` | n/a | yes |
| <a name="input_apikey"></a> [apikey](#input\_apikey) | Intersight API Key. | `string` | n/a | yes |
| <a name="input_container_runtime_http_password"></a> [container\_runtime\_http\_password](#input\_container\_runtime\_http\_password) | Password for the HTTP Proxy Server, If required. | `string` | `""` | no |
| <a name="input_container_runtime_https_password"></a> [container\_runtime\_https\_password](#input\_container\_runtime\_https\_password) | Password for the HTTPS Proxy Server, If required. | `string` | `""` | no |
| <a name="input_container_runtime_policies"></a> [container\_runtime\_policies](#input\_container\_runtime\_policies) | Please Refer to OSS Model Below for Variable Details | `string` | n/a | yes |
| <a name="input_endpoint"></a> [endpoint](#input\_endpoint) | Intersight URL. | `string` | `"https://intersight.com"` | no |
| <a name="input_ip_pools"></a> [ip\_pools](#input\_ip\_pools) | Please Refer to OSS Model Below for Variable Details | `string` | n/a | yes |
| <a name="input_kubernetes_version_policies"></a> [kubernetes\_version\_policies](#input\_kubernetes\_version\_policies) | Please Refer to OSS Model Below for Variable Details | `string` | n/a | yes |
| <a name="input_network_cidr_policies"></a> [network\_cidr\_policies](#input\_network\_cidr\_policies) | Please Refer to OSS Model Below for Variable Details | `string` | n/a | yes |
| <a name="input_nodeos_configuration_policies"></a> [nodeos\_configuration\_policies](#input\_nodeos\_configuration\_policies) | Please See the OSS Variable Information Below. | `string` | n/a | yes |
| <a name="input_organizations"></a> [organizations](#input\_organizations) | Intersight Organization Names to Apply Policy to.  https://intersight.com/an/settings/organizations/. | `set(string)` | n/a | yes |
| <a name="input_secretkey"></a> [secretkey](#input\_secretkey) | Intersight Secret Key. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Please Refer to the tags variable information in the tfe module.  In the k8s\_policies module the variable is accepted as a string from terraform cloud in the terraform.auto.tfvars and extracted using locals. | `list(map(string))` | n/a | yes |
| <a name="input_trusted_certificate_authorities"></a> [trusted\_certificate\_authorities](#input\_trusted\_certificate\_authorities) | Please Refer to OSS Model Below for Variable Details | `string` | n/a | yes |
| <a name="input_virtual_machine_infra_config"></a> [virtual\_machine\_infra\_config](#input\_virtual\_machine\_infra\_config) | Please Refer to OSS Model Below for Variable Details | `string` | n/a | yes |
| <a name="input_virtual_machine_instance_type"></a> [virtual\_machine\_instance\_type](#input\_virtual\_machine\_instance\_type) | Please Refer to OSS Model Below for Variable Details | `string` | n/a | yes |
| <a name="input_vm_infra_config_password"></a> [vm\_infra\_config\_password](#input\_vm\_infra\_config\_password) | vSphere Password.  Note: this is the password of the Credentials used to register the vSphere Target. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_addons_policies"></a> [addons\_policies](#output\_addons\_policies) | moid of the Kubernetes Addon Policies. |
| <a name="output_container_runtime_policies"></a> [container\_runtime\_policies](#output\_container\_runtime\_policies) | moid of the Kubernetes Runtime Policies. |
| <a name="output_endpoint"></a> [endpoint](#output\_endpoint) | Intersight URL. |
| <a name="output_ip_pools"></a> [ip\_pools](#output\_ip\_pools) | moid of the IP Pools. |
| <a name="output_kubernetes_version_policies"></a> [kubernetes\_version\_policies](#output\_kubernetes\_version\_policies) | moid of the Kubernetes Version Policies. |
| <a name="output_network_cidr_policies"></a> [network\_cidr\_policies](#output\_network\_cidr\_policies) | moid of the Kubernetes Network CIDR Policies. |
| <a name="output_nodeos_configuration_policies"></a> [nodeos\_configuration\_policies](#output\_nodeos\_configuration\_policies) | moid of the Kubernetes Node OS Config Policies. |
| <a name="output_org_moids"></a> [org\_moids](#output\_org\_moids) | n/a |
| <a name="output_tags"></a> [tags](#output\_tags) | Tags to be Associated with Objects Created in Intersight. |
| <a name="output_trusted_certificate_authorities"></a> [trusted\_certificate\_authorities](#output\_trusted\_certificate\_authorities) | moid of the Kubernetes Trusted Certificate Authorities Policy. |
| <a name="output_virtual_machine_infra_config"></a> [virtual\_machine\_infra\_config](#output\_virtual\_machine\_infra\_config) | moid of the Kubernetes Virtual Machine Infrastructure Configuration Policies. |
| <a name="output_virtual_machine_instance_type"></a> [virtual\_machine\_instance\_type](#output\_virtual\_machine\_instance\_type) | moid of the Virtual Machine Instance Type Policies. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

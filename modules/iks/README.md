# Intersight Kubernetes Service Cluster Profile Module

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
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_control_plane_node_group"></a> [control\_plane\_node\_group](#module\_control\_plane\_node\_group) | terraform-cisco-modules/imm/intersight//modules/k8s_node_group_profile | n/a |
| <a name="module_control_plane_vm_infra_provider"></a> [control\_plane\_vm\_infra\_provider](#module\_control\_plane\_vm\_infra\_provider) | terraform-cisco-modules/imm/intersight//modules/k8s_node_vm_infra_provider | n/a |
| <a name="module_iks_addon_profile"></a> [iks\_addon\_profile](#module\_iks\_addon\_profile) | terraform-cisco-modules/imm/intersight//modules/k8s_cluster_addons | n/a |
| <a name="module_iks_cluster"></a> [iks\_cluster](#module\_iks\_cluster) | terraform-cisco-modules/imm/intersight//modules/k8s_cluster | n/a |
| <a name="module_worker_node_group"></a> [worker\_node\_group](#module\_worker\_node\_group) | terraform-cisco-modules/imm/intersight//modules/k8s_node_group_profile | n/a |
| <a name="module_worker_vm_infra_provider"></a> [worker\_vm\_infra\_provider](#module\_worker\_vm\_infra\_provider) | terraform-cisco-modules/imm/intersight//modules/k8s_node_vm_infra_provider | n/a |

## Resources

| Name | Type |
|------|------|
| [terraform_remote_state.organization](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_apikey"></a> [apikey](#input\_apikey) | Intersight API Key. | `string` | n/a | yes |
| <a name="input_iks_cluster"></a> [iks\_cluster](#input\_iks\_cluster) | Please Refer to the iks\_cluster variable information in the tfe module.  In the iks module the variable is accepted as a string from terraform cloud in the terraform.auto.tfvars and extracted using locals. | `string` | n/a | yes |
| <a name="input_organization"></a> [organization](#input\_organization) | Intersight Organization Name/Workspace. | `string` | `"default"` | no |
| <a name="input_secretkey"></a> [secretkey](#input\_secretkey) | Intersight Secret Key. | `string` | n/a | yes |
| <a name="input_ssh_key_1"></a> [ssh\_key\_1](#input\_ssh\_key\_1) | Intersight Kubernetes Service Cluster SSH Public Key 1. | `string` | `""` | no |
| <a name="input_ssh_key_2"></a> [ssh\_key\_2](#input\_ssh\_key\_2) | Intersight Kubernetes Service Cluster SSH Public Key 2.  These are place holders for Tenants that use different keys for different clusters. | `string` | `""` | no |
| <a name="input_ssh_key_3"></a> [ssh\_key\_3](#input\_ssh\_key\_3) | Intersight Kubernetes Service Cluster SSH Public Key 3.  These are place holders for Tenants that use different keys for different clusters. | `string` | `""` | no |
| <a name="input_ssh_key_4"></a> [ssh\_key\_4](#input\_ssh\_key\_4) | Intersight Kubernetes Service Cluster SSH Public Key 4.  These are place holders for Tenants that use different keys for different clusters. | `string` | `""` | no |
| <a name="input_ssh_key_5"></a> [ssh\_key\_5](#input\_ssh\_key\_5) | Intersight Kubernetes Service Cluster SSH Public Key 5.  These are place holders for Tenants that use different keys for different clusters. | `string` | `""` | no |
| <a name="input_tfc_organization"></a> [tfc\_organization](#input\_tfc\_organization) | Terraform Cloud Organization Name. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_endpoint"></a> [endpoint](#output\_endpoint) | Intersight URL. |
| <a name="output_iks_cluster"></a> [iks\_cluster](#output\_iks\_cluster) | moid of the IKS Cluster. |
| <a name="output_org_moid"></a> [org\_moid](#output\_org\_moid) | moid of the Intersight Organization. |
| <a name="output_organization"></a> [organization](#output\_organization) | Intersight Organization Name. |
| <a name="output_tags"></a> [tags](#output\_tags) | Tags to be Associated with Objects Created in Intersight. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

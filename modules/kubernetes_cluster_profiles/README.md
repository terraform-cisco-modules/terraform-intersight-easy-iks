# Intersight Kubernetes Service Cluster Profile Module

## Use this module to create Kubernetes policies and an IKS Cluster profile in Intersight

Run the plan from the Terraform cloud workspace.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_intersight"></a> [intersight](#requirement\_intersight) | 1.0.13 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_control_plane_node_vm_infra"></a> [control\_plane\_node\_vm\_infra](#module\_control\_plane\_node\_vm\_infra) | terraform-cisco-modules/imm/intersight//modules/kubernetes_cluster_node_vm_infra | n/a |
| <a name="module_kubernetes_cluster_addons"></a> [kubernetes\_cluster\_addons](#module\_kubernetes\_cluster\_addons) | ../../../terraform-intersight-imm/modules/kubernetes_cluster_addons | n/a |
| <a name="module_kubernetes_cluster_profiles"></a> [kubernetes\_cluster\_profiles](#module\_kubernetes\_cluster\_profiles) | terraform-cisco-modules/imm/intersight//modules/kubernetes_cluster_profiles | n/a |
| <a name="module_kubernetes_node_pools"></a> [kubernetes\_node\_pools](#module\_kubernetes\_node\_pools) | terraform-cisco-modules/imm/intersight//modules/kubernetes_node_group_profiles | n/a |

## Resources

| Name | Type |
|------|------|
| [terraform_remote_state.kubernetes_policies](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_apikey"></a> [apikey](#input\_apikey) | Intersight API Key. | `string` | n/a | yes |
| <a name="input_kubernetes_cluster_profiles"></a> [kubernetes\_cluster\_profiles](#input\_kubernetes\_cluster\_profiles) | Intersight Kubernetes Service Cluster Profile Variable Map.<br>* action - Action to perform on the Kubernetes Cluster.  Options are {Delete\|Deploy\|Ready\|No-op\|Unassign}.<br>* addons\_policy\_moid - Names of the Kubernetes Add-ons to add to the cluster.  Options are {ccp-monitor\|kubernetes-dashboard} or [].<br>* container\_runtime\_moid - Name of the Kubernetes Runtime Policy to assign to Cluster and Node Profiles.<br>* description - A description for the policy.<br>* ip\_pool\_moid - Name of the IP Pool to assign to Cluster and Node Profiles.<br>* network\_cidr\_moid - Name of the Kubneretes Network CIDR Policy to assign to Cluster.<br>* node\_pools -   This is the Variable Block for both Control Plane Nodes and Worker Nodes.<br>  - action - Action to perform on the Kubernetes Control Plane Nodes.  Options are {Delete\|Deploy\|Ready\|No-op\|Unassign}.<br>  - description - A description for the Policy.<br>  - desired\_size - Desired number of control plane nodes in this node group, same as minsize initially and is updated by the auto-scaler.  Options are {1\|3}.<br>  - ip\_pool\_moid - Name of the IP Pool to assign to Cluster and Node Profiles.  If not Assigned it will assign the ip\_pool assigned to the cluster.<br>  - kubernetes\_cluster\_moid - Name of the Kubernetes Cluster Profile.<br>  - kubernetes\_labels - List of key/value Attributes to Assign to the control plane node configuration.<br>  - kubernetes\_version\_moid - Name of the Kubernetes Version Policy to assign to the Node Profiles.<br>  - max\_size - Maximum number of nodes desired in this node pool.  Range is 1-128.<br>  - min\_size - Minimum number of nodes desired in this node pool.  Range is 1-128.<br>  - node\_type - The node type:<br>    * ControlPlane - Node will be marked as a control plane node.<br>    * ControlPlaneWorker - Node will be both a controle plane and a worker.<br>    * Worker - Node will be marked as a worker node.<br>  - organization - Name of the Intersight Organization to assign this pool to.  https://intersight.com/an/settings/organizations/<br>  - vm\_instance\_type\_moid - Name of the Kubernetes Virtual Machine Instance Type Policy to assign to control plane nodes.<br>  - vm\_infra\_config\_moid - Name of the Kubernetes Virtual Machine Infra Config Policy to assign to the Node Profiles.<br><br>* nodeos\_configuration\_moid - Name of the Kubneretes Node OS Config Policy to assign to Cluster and Node Profiles.<br>* load\_balancer\_count - Number of load balancer addresses to deploy. Range is 1-999.<br>* organization - Name of the Intersight Organization to assign this pool to.  https://intersight.com/an/settings/organizations/<br>* ssh\_public\_key - The SSH Public Key should be ssh\_public\_key\_{1\|2\|3\|4\|5}.  This will point to the ssh\_public\_key variable that will be used.<br>* ssh\_user - SSH Username for node login.<br>* tags - tags - List of key/value Attributes to Assign to the Profile.<br>* trusted\_certificate\_authority\_moid - Name of the Kubernetes Trusted Registry Policy to assign to Cluster and Node Profiles<br>* wait\_for\_complete - This model object can trigger workflows. Use this option to wait for all running workflows to reach a complete state. | <pre>map(object(<br>    {<br>      action                 = optional(string)<br>      addons_policy_moid     = optional(set(string))<br>      container_runtime_moid = optional(string)<br>      description            = optional(string)<br>      ip_pool_moid           = string<br>      network_cidr_moid      = string<br>      node_pools = map(object(<br>        {<br>          action                  = optional(string)<br>          description             = optional(string)<br>          desired_size            = optional(number)<br>          ip_pool_moid            = optional(string)<br>          kubernetes_labels       = optional(list(map(string)))<br>          kubernetes_version_moid = string<br>          max_size                = optional(number)<br>          min_size                = optional(number)<br>          node_type               = string<br>          vm_instance_type_moid   = string<br>          vm_infra_config_moid    = string<br>        }<br>      ))<br>      nodeos_configuration_moid          = string<br>      trusted_certificate_authority_moid = optional(string)<br>      load_balancer_count                = optional(number)<br>      organization                       = optional(string)<br>      ssh_public_key                     = string<br>      ssh_user                           = string<br>      tags                               = optional(list(map(string)))<br>      wait_for_complete                  = optional(bool)<br>    }<br>  ))</pre> | <pre>{<br>  "default": {<br>    "action": "Deploy",<br>    "addons_policy_moid": [],<br>    "container_runtime_moid": "",<br>    "description": "",<br>    "ip_pool_moid": "**REQUIRED**",<br>    "load_balancer_count": 3,<br>    "network_cidr_moid": "**REQUIRED**",<br>    "node_pools": {},<br>    "nodeos_configuration_moid": "**REQUIRED**",<br>    "organization": "default",<br>    "ssh_public_key": "ssh_public_key_1",<br>    "ssh_user": "iksadmin",<br>    "tags": [],<br>    "trusted_certificate_authority_moid": "",<br>    "wait_for_complete": false<br>  }<br>}</pre> | no |
| <a name="input_secretkey"></a> [secretkey](#input\_secretkey) | Intersight Secret Key. | `string` | n/a | yes |
| <a name="input_ssh_public_key_1"></a> [ssh\_public\_key\_1](#input\_ssh\_public\_key\_1) | Intersight Kubernetes Service Cluster SSH Public Key 1. | `string` | `""` | no |
| <a name="input_ssh_public_key_2"></a> [ssh\_public\_key\_2](#input\_ssh\_public\_key\_2) | Intersight Kubernetes Service Cluster SSH Public Key 2.  These are place holders for Clusters that use different keys for different clusters. | `string` | `""` | no |
| <a name="input_ssh_public_key_3"></a> [ssh\_public\_key\_3](#input\_ssh\_public\_key\_3) | Intersight Kubernetes Service Cluster SSH Public Key 3.  These are place holders for Clusters that use different keys for different clusters. | `string` | `""` | no |
| <a name="input_ssh_public_key_4"></a> [ssh\_public\_key\_4](#input\_ssh\_public\_key\_4) | Intersight Kubernetes Service Cluster SSH Public Key 4.  These are place holders for Clusters that use different keys for different clusters. | `string` | `""` | no |
| <a name="input_ssh_public_key_5"></a> [ssh\_public\_key\_5](#input\_ssh\_public\_key\_5) | Intersight Kubernetes Service Cluster SSH Public Key 5.  These are place holders for Clusters that use different keys for different clusters. | `string` | `""` | no |
| <a name="input_tfc_organization"></a> [tfc\_organization](#input\_tfc\_organization) | Terraform Cloud Organization Name. | `string` | n/a | yes |
| <a name="input_tfc_workspace"></a> [tfc\_workspace](#input\_tfc\_workspace) | Name of the Kubernetes Policies workspace. | `string` | `"kubernetes_policies"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_endpoint"></a> [endpoint](#output\_endpoint) | Intersight URL. |
| <a name="output_kubernetes_cluster_profiles"></a> [kubernetes\_cluster\_profiles](#output\_kubernetes\_cluster\_profiles) | moid of the Kubernetes Cluster Profiles. |
| <a name="output_org_moids"></a> [org\_moids](#output\_org\_moids) | moid of the Intersight Organization. |
| <a name="output_tags"></a> [tags](#output\_tags) | Tags to be Associated with Objects Created in Intersight. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

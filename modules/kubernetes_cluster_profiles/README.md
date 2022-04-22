# Intersight Kubernetes Service Cluster Profile Module

## Use this module to create Kubernetes policies and an IKS Cluster profile in Intersight

Run the plan from the Terraform cloud workspace.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_intersight"></a> [intersight](#requirement\_intersight) | >=1.0.21 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_intersight"></a> [intersight](#provider\_intersight) | 1.0.26 |
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [intersight_kubernetes_cluster_addon_profile.cluster_addon](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/resources/kubernetes_cluster_addon_profile) | resource |
| [intersight_kubernetes_cluster_profile.kubernetes_cluster_profiles](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/resources/kubernetes_cluster_profile) | resource |
| [intersight_kubernetes_node_group_profile.kubernetes_node_pools](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/resources/kubernetes_node_group_profile) | resource |
| [intersight_kubernetes_virtual_machine_infrastructure_provider.k8s_vm_infra_provider](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/resources/kubernetes_virtual_machine_infrastructure_provider) | resource |
| [terraform_remote_state.local_policies](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.remote_policies](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_apikey"></a> [apikey](#input\_apikey) | Intersight API Key. | `string` | n/a | yes |
| <a name="input_kubernetes_cluster_profiles"></a> [kubernetes\_cluster\_profiles](#input\_kubernetes\_cluster\_profiles) | Intersight Kubernetes Service Cluster Profile Variable Map.<br>* action - Action to perform on the Kubernetes Cluster.  Options are {Delete\|Deploy\|Ready\|No-op\|Unassign}.<br>* addons\_policies - Names of the Kubernetes Add-ons to add to the cluster.  Options are {ccp-monitor\|kubernetes-dashboard} or [].<br>* cluster\_configuration - IKS Cluster Settings:<br>  - kubernetes\_api\_vip - VIP for the cluster Kubernetes API server. If this is empty and a cluster IP pool is specified, it will be allocated from the IP pool.<br>  - load\_balancer\_count - Number of load balancer addresses to deploy. Range is 1-999.<br>  - ssh\_public\_key - The SSH Public Key should be 1.  This will point to the ssh\_public\_key variable that will be used.<br>* container\_runtime\_policy - Name of the Kubernetes Runtime Policy to assign to Cluster and Node Profiles.<br>* description - A description for the policy.<br>* ip\_pool - Name of the IP Pool to assign to Cluster and Node Profiles.<br>* network\_cidr\_policy - Name of the Kubneretes Network CIDR Policy to assign to Cluster.<br>* node\_pools -   This Map of Objects is for both Control Plane Nodes and Worker Nodes.<br>  - action - Action to perform on the Kubernetes Control Plane Nodes.  Options are {Delete\|Deploy\|Ready\|No-op\|Unassign}.<br>  - description - A description for the Policy.<br>  - desired\_size - Desired number of control plane nodes in this node group, same as minsize initially and is updated by the auto-scaler.  Options are {1\|3}.<br>  - ip\_pool - Name of the IP Pool to assign to Cluster and Node Profiles.  If not Assigned it will assign the ip\_pool assigned to the cluster.<br>  - kubernetes\_cluster\_policy - Name of the Kubernetes Cluster Profile.<br>  - kubernetes\_labels - List of key/value Attributes to Assign to the control plane node configuration.<br>    NOTE: The Key and Value should adhere to the following naming standards:<br>    * must be 63 characters or less (can be empty),<br>    * unless empty, must begin and end with an alphanumeric character ([a-z0-9A-Z]),<br>    * could contain dashes (-), underscores (\_), dots (.), and alphanumerics between.<br>    * (([A-Za-z0-9][-\_A-Za-z0-9.]*)?[A-Za-z0-9])?').<br>  - kubernetes\_version\_policy - Name of the Kubernetes Version Policy to assign to the Node Profiles.<br>  - max\_size - Maximum number of nodes desired in this node pool.  Range is 1-128.<br>  - min\_size - Minimum number of nodes desired in this node pool.  Range is 1-128.<br>  - node\_type - The node type:<br>    * ControlPlane - Node will be marked as a control plane node.<br>    * ControlPlaneWorker - Node will be both a controle plane and a worker.<br>    * Worker - Node will be marked as a worker node.<br>  - vm\_instance\_type\_policy - Name of the Kubernetes Virtual Machine Instance Type Policy to assign to control plane nodes.<br>  - vm\_infra\_config\_policy - Name of the Kubernetes Virtual Machine Infra Config Policy to assign to the Node Profiles.<br><br>* nodeos\_configuration\_policy - Name of the Kubneretes Node OS Config Policy to assign to Cluster and Node Profiles.<br>* tags - tags - List of key/value Attributes to Assign to the Profile.<br>* trusted\_certificate\_authority - Name of the Kubernetes Trusted Registry Policy to assign to Cluster and Node Profiles<br>* wait\_for\_completion - This model object can trigger workflows. Use this option to wait for all running workflows to reach a complete state. | <pre>map(object(<br>    {<br>      action                    = optional(string)<br>      addons_policies           = optional(set(string))<br>      certificate_configuration = bool<br>      cluster_configuration = list(object(<br>        {<br>          kubernetes_api_vip  = optional(string)<br>          load_balancer_count = optional(number)<br>          ssh_public_key      = optional(number)<br>          # ssh_user            = optional(string)<br>        }<br>      ))<br>      container_runtime_policy = optional(string)<br>      description              = optional(string)<br>      ip_pool                  = string<br>      network_cidr_policy      = string<br>      node_pools = map(object(<br>        {<br>          # action                    = optional(string)<br>          description               = optional(string)<br>          desired_size              = optional(number)<br>          ip_pool                   = optional(string)<br>          kubernetes_labels         = optional(list(map(string)))<br>          kubernetes_version_policy = string<br>          max_size                  = optional(number)<br>          min_size                  = optional(number)<br>          node_type                 = string<br>          vm_instance_type_policy   = string<br>          vm_infra_config_policy    = string<br>        }<br>      ))<br>      nodeos_configuration_policy   = string<br>      trusted_certificate_authority = optional(string)<br>      tags                          = optional(list(map(string)))<br>      wait_for_completion           = optional(bool)<br>    }<br>  ))</pre> | <pre>{<br>  "default": {<br>    "action": "No-op",<br>    "addons_policies": [<br>      "default"<br>    ],<br>    "certificate_configuration": false,<br>    "cluster_configuration": [<br>      {<br>        "kubernetes_api_vip": "",<br>        "load_balancer_count": 3,<br>        "ssh_public_key": 1<br>      }<br>    ],<br>    "container_runtime_policy": "default",<br>    "description": "",<br>    "ip_pool": "default",<br>    "network_cidr_policy": "default",<br>    "node_pools": {<br>      "0": {<br>        "description": "",<br>        "desired_size": 1,<br>        "ip_pool": "",<br>        "kubernetes_labels": [],<br>        "kubernetes_version_policy": "default",<br>        "max_size": 3,<br>        "min_size": 1,<br>        "node_type": "ControlPlaneWorker",<br>        "vm_infra_config_policy": "default",<br>        "vm_instance_type_policy": "default"<br>      }<br>    },<br>    "nodeos_configuration_policy": "default",<br>    "tags": [],<br>    "trusted_certificate_authority": "",<br>    "wait_for_completion": false<br>  }<br>}</pre> | no |
| <a name="input_secretkey"></a> [secretkey](#input\_secretkey) | Intersight Secret Key. | `string` | n/a | yes |
| <a name="input_ssh_public_key"></a> [ssh\_public\_key](#input\_ssh\_public\_key) | Intersight Kubernetes Service Cluster SSH Public Key. | `string` | `""` | no |
| <a name="input_tfc_workspaces"></a> [tfc\_workspaces](#input\_tfc\_workspaces) | * backend: Options are:<br>  - local - The backend is on the Local Machine<br>  - Remote - The backend is in TFCB.<br>* organization: Name of the Terraform Cloud Organization when backend is remote.<br>* policies\_dir: Name of the Policies directory when the backend is local.<br>* workspace: Name of the workspace in Terraform Cloud. | <pre>list(object(<br>    {<br>      backend      = string<br>      organization = optional(string)<br>      policies_dir = optional(string)<br>      workspace    = optional(string)<br>    }<br>  ))</pre> | <pre>[<br>  {<br>    "backend": "remote",<br>    "organization": "default",<br>    "policies_dir": "../kubernetes_policies/",<br>    "workspace": "kubernetes_policies"<br>  }<br>]</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster_profiles"></a> [cluster\_profiles](#output\_cluster\_profiles) | moid of the Kubernetes Cluster Profiles. |
| <a name="output_endpoint"></a> [endpoint](#output\_endpoint) | Intersight URL. |
| <a name="output_org_moid"></a> [org\_moid](#output\_org\_moid) | moid of the Intersight Organization. |
| <a name="output_tags"></a> [tags](#output\_tags) | Tags to be Associated with Objects Created in Intersight. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

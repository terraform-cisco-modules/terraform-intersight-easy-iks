# IKS Policies and Cluster Profile Module

## Use this module to create Kubernetes policies and an IKS Cluster profile in Intersight

Run the plan from the Terraform cloud workspace.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_intersight"></a> [intersight](#requirement\_intersight) | 1.0.9 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_intersight"></a> [intersight](#provider\_intersight) | 1.0.9 |
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_iks_addon_profile"></a> [iks\_addon\_profile](#module\_iks\_addon\_profile) | terraform-cisco-modules/iks/intersight//modules/cluster_addon_profile | n/a |
| <a name="module_iks_cluster"></a> [iks\_cluster](#module\_iks\_cluster) | terraform-cisco-modules/iks/intersight//modules/cluster | n/a |
| <a name="module_ip_pool"></a> [ip\_pool](#module\_ip\_pool) | terraform-cisco-modules/iks/intersight//modules/ip_pool | n/a |
| <a name="module_k8s_addons"></a> [k8s\_addons](#module\_k8s\_addons) | terraform-cisco-modules/iks/intersight//modules/addon_policy | n/a |
| <a name="module_k8s_instance_large"></a> [k8s\_instance\_large](#module\_k8s\_instance\_large) | terraform-cisco-modules/iks/intersight//modules/worker_profile | n/a |
| <a name="module_k8s_instance_medium"></a> [k8s\_instance\_medium](#module\_k8s\_instance\_medium) | terraform-cisco-modules/iks/intersight//modules/worker_profile | n/a |
| <a name="module_k8s_instance_small"></a> [k8s\_instance\_small](#module\_k8s\_instance\_small) | terraform-cisco-modules/iks/intersight//modules/worker_profile | n/a |
| <a name="module_k8s_runtime_policy"></a> [k8s\_runtime\_policy](#module\_k8s\_runtime\_policy) | terraform-cisco-modules/iks/intersight//modules/runtime_policy | n/a |
| <a name="module_k8s_trusted_registry"></a> [k8s\_trusted\_registry](#module\_k8s\_trusted\_registry) | terraform-cisco-modules/iks/intersight//modules/trusted_registry | n/a |
| <a name="module_k8s_version_policy"></a> [k8s\_version\_policy](#module\_k8s\_version\_policy) | terraform-cisco-modules/iks/intersight//modules/version | n/a |
| <a name="module_k8s_vm_infra_policy"></a> [k8s\_vm\_infra\_policy](#module\_k8s\_vm\_infra\_policy) | terraform-cisco-modules/iks/intersight//modules/infra_config_policy | n/a |
| <a name="module_k8s_vm_network_policy"></a> [k8s\_vm\_network\_policy](#module\_k8s\_vm\_network\_policy) | terraform-cisco-modules/iks/intersight//modules/k8s_network | n/a |
| <a name="module_master_instance_type"></a> [master\_instance\_type](#module\_master\_instance\_type) | terraform-cisco-modules/iks/intersight//modules/infra_provider | n/a |
| <a name="module_master_profile"></a> [master\_profile](#module\_master\_profile) | terraform-cisco-modules/iks/intersight//modules/node_profile | n/a |
| <a name="module_worker_instance_type"></a> [worker\_instance\_type](#module\_worker\_instance\_type) | terraform-cisco-modules/iks/intersight//modules/infra_provider | n/a |
| <a name="module_worker_profile"></a> [worker\_profile](#module\_worker\_profile) | terraform-cisco-modules/iks/intersight//modules/node_profile | n/a |

## Resources

| Name | Type |
|------|------|
| [intersight_organization_organization.organization_moid](https://registry.terraform.io/providers/CiscoDevNet/intersight/1.0.9/docs/data-sources/organization_organization) | data source |
| [terraform_remote_state.global](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_action"></a> [action](#input\_action) | Action to perform on the Intersight Kubernetes Cluster.  Options are {Delete\|Deploy\|Ready\|Unassign}. | `string` | `"Deploy"` | no |
| <a name="input_apikey"></a> [apikey](#input\_apikey) | Intersight API Key. | `string` | n/a | yes |
| <a name="input_cni"></a> [cni](#input\_cni) | Supported CNI type. Currently we only support Calico.<br>* Calico - Calico CNI plugin as described in:<br> https://github.com/projectcalico/cni-plugin. | `string` | `"Calico"` | no |
| <a name="input_docker_no_proxy"></a> [docker\_no\_proxy](#input\_docker\_no\_proxy) | Docker no proxy list, when using internet proxy.  Default is no list. | `list(string)` | `[]` | no |
| <a name="input_k8s_pod_cidr"></a> [k8s\_pod\_cidr](#input\_k8s\_pod\_cidr) | Pod CIDR Block to be used to assign Pod IP Addresses. | `string` | `"100.65.0.0/16"` | no |
| <a name="input_k8s_service_cidr"></a> [k8s\_service\_cidr](#input\_k8s\_service\_cidr) | Service CIDR Block used to assign Cluster Service IP Addresses. | `string` | `"100.64.0.0/16"` | no |
| <a name="input_k8s_version"></a> [k8s\_version](#input\_k8s\_version) | Kubernetes Version to Deploy. | `string` | `"1.19.5"` | no |
| <a name="input_load_balancers"></a> [load\_balancers](#input\_load\_balancers) | Intersight Kubernetes Load Balancer count. | `string` | `3` | no |
| <a name="input_master_desired_size"></a> [master\_desired\_size](#input\_master\_desired\_size) | K8S Master Desired Cluster Size. | `string` | `1` | no |
| <a name="input_master_instance_type"></a> [master\_instance\_type](#input\_master\_instance\_type) | K8S Master Virtual Machine Instance Type.  Options are {small\|medium\|large}. | `string` | `"small"` | no |
| <a name="input_master_max_size"></a> [master\_max\_size](#input\_master\_max\_size) | K8S Master Maximum Cluster Size. | `string` | `1` | no |
| <a name="input_proxy_http_password"></a> [proxy\_http\_password](#input\_proxy\_http\_password) | Password for the HTTP Proxy Server, If required. | `string` | `""` | no |
| <a name="input_proxy_http_port"></a> [proxy\_http\_port](#input\_proxy\_http\_port) | Proxy HTTP Port. | `string` | `"8080"` | no |
| <a name="input_proxy_http_protocol"></a> [proxy\_http\_protocol](#input\_proxy\_http\_protocol) | Proxy HTTP Protocol. | `string` | `"http"` | no |
| <a name="input_proxy_https_password"></a> [proxy\_https\_password](#input\_proxy\_https\_password) | Password for the HTTPS Proxy Server, If required. | `string` | `""` | no |
| <a name="input_proxy_https_port"></a> [proxy\_https\_port](#input\_proxy\_https\_port) | Proxy HTTP Port. | `string` | `"8443"` | no |
| <a name="input_proxy_https_protocol"></a> [proxy\_https\_protocol](#input\_proxy\_https\_protocol) | Proxy HTTP Protocol. | `string` | `"https"` | no |
| <a name="input_root_ca_registries"></a> [root\_ca\_registries](#input\_root\_ca\_registries) | List of root CA Signed Registries. | `list(string)` | `[]` | no |
| <a name="input_secretkey"></a> [secretkey](#input\_secretkey) | Intersight Secret Key. | `string` | n/a | yes |
| <a name="input_ssh_key"></a> [ssh\_key](#input\_ssh\_key) | Intersight Kubernetes Service Cluster SSH Public Key. | `string` | n/a | yes |
| <a name="input_ssh_user"></a> [ssh\_user](#input\_ssh\_user) | Intersight Kubernetes Service Cluster Default User. | `string` | `"iksadmin"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to be Associated with Objects Created in Intersight. | `list(map(string))` | `[]` | no |
| <a name="input_tfc_organization"></a> [tfc\_organization](#input\_tfc\_organization) | Terraform Cloud Organization. | `string` | `"CiscoDevNet"` | no |
| <a name="input_unsigned_registries"></a> [unsigned\_registries](#input\_unsigned\_registries) | List of unsigned registries to be supported. | `list(string)` | `[]` | no |
| <a name="input_vsphere_cluster"></a> [vsphere\_cluster](#input\_vsphere\_cluster) | vSphere Cluster to assign the K8S Cluster Deployment. | `string` | `"hx-demo"` | no |
| <a name="input_vsphere_datastore"></a> [vsphere\_datastore](#input\_vsphere\_datastore) | vSphere Datastore to assign the K8S Cluster Deployment. | `string` | `"hx-demo-ds1"` | no |
| <a name="input_vsphere_password"></a> [vsphere\_password](#input\_vsphere\_password) | vSphere Password.  Note: this is the password of the Credentials used to register the vSphere Target. | `string` | n/a | yes |
| <a name="input_vsphere_portgroup"></a> [vsphere\_portgroup](#input\_vsphere\_portgroup) | vSphere Port Group to assign the K8S Cluster Deployment. | `list` | <pre>[<br>  "Management"<br>]</pre> | no |
| <a name="input_vsphere_resource_pool"></a> [vsphere\_resource\_pool](#input\_vsphere\_resource\_pool) | vSphere Resource Pool to assign the K8S Cluster Deployment. | `string` | `""` | no |
| <a name="input_worker_desired_size"></a> [worker\_desired\_size](#input\_worker\_desired\_size) | K8S Worker Desired Cluster Size. | `string` | `0` | no |
| <a name="input_worker_instance_type"></a> [worker\_instance\_type](#input\_worker\_instance\_type) | K8S Worker Virtual Machine Instance Type.  Options are {small\|medium\|large}. | `string` | `"small"` | no |
| <a name="input_worker_max_size"></a> [worker\_max\_size](#input\_worker\_max\_size) | K8S Worker Maximum Cluster Size. | `string` | `4` | no |
| <a name="input_ws_global_vars"></a> [ws\_global\_vars](#input\_ws\_global\_vars) | Global Variables Workspace Name.  The default value will be set to {cluster\_name}\_global\_vars by the tfe variable module. | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_iks_cluster"></a> [iks\_cluster](#output\_iks\_cluster) | moid of the IKS Cluster. |
| <a name="output_ip_pool"></a> [ip\_pool](#output\_ip\_pool) | moid of the IP Pool |
| <a name="output_k8s_instance_large"></a> [k8s\_instance\_large](#output\_k8s\_instance\_large) | moid of the Large Kubernetes Instance Type. |
| <a name="output_k8s_instance_medium"></a> [k8s\_instance\_medium](#output\_k8s\_instance\_medium) | moid of the Medium Kubernetes Instance Type. |
| <a name="output_k8s_instance_small"></a> [k8s\_instance\_small](#output\_k8s\_instance\_small) | moid of the Small Kubernetes Instance Type. |
| <a name="output_k8s_network_cidr"></a> [k8s\_network\_cidr](#output\_k8s\_network\_cidr) | moid of the Kubernetes CIDR Policy. |
| <a name="output_k8s_nodeos_config"></a> [k8s\_nodeos\_config](#output\_k8s\_nodeos\_config) | moid of the Kubernetes Node OS Config Policy. |
| <a name="output_k8s_trusted_registry"></a> [k8s\_trusted\_registry](#output\_k8s\_trusted\_registry) | moid of the Kubernetes Trusted Registry Policy. |
| <a name="output_k8s_version_policy"></a> [k8s\_version\_policy](#output\_k8s\_version\_policy) | moid of the Kubernetes Version Policy. |
| <a name="output_k8s_vm_infra_policy"></a> [k8s\_vm\_infra\_policy](#output\_k8s\_vm\_infra\_policy) | moid of the Kubernetes VM Infrastructure Policy. |
| <a name="output_master_profile"></a> [master\_profile](#output\_master\_profile) | moid of the Master Node Profile. |
| <a name="output_organization_moid"></a> [organization\_moid](#output\_organization\_moid) | moid of the Intersight Organization. |
| <a name="output_worker_profile"></a> [worker\_profile](#output\_worker\_profile) | moid of the Worker Node Profile. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

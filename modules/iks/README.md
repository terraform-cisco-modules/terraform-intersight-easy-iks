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
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_control_plane_instance_type"></a> [control\_plane\_instance\_type](#module\_control\_plane\_instance\_type) | terraform-cisco-modules/iks/intersight//modules/infra_provider | n/a |
| <a name="module_control_plane_profile"></a> [control\_plane\_profile](#module\_control\_plane\_profile) | terraform-cisco-modules/iks/intersight//modules/node_profile | n/a |
| <a name="module_iks_addon_profile"></a> [iks\_addon\_profile](#module\_iks\_addon\_profile) | terraform-cisco-modules/iks/intersight//modules/cluster_addon_profile | n/a |
| <a name="module_iks_cluster"></a> [iks\_cluster](#module\_iks\_cluster) | terraform-cisco-modules/iks/intersight//modules/cluster | n/a |
| <a name="module_k8s_addons"></a> [k8s\_addons](#module\_k8s\_addons) | terraform-cisco-modules/iks/intersight//modules/addon_policy | n/a |
| <a name="module_worker_instance_type"></a> [worker\_instance\_type](#module\_worker\_instance\_type) | terraform-cisco-modules/iks/intersight//modules/infra_provider | n/a |
| <a name="module_worker_profile"></a> [worker\_profile](#module\_worker\_profile) | terraform-cisco-modules/iks/intersight//modules/node_profile | n/a |

## Resources

| Name | Type |
|------|------|
| [intersight_organization_organization.organization_moid](https://registry.terraform.io/providers/CiscoDevNet/intersight/1.0.11/docs/data-sources/organization_organization) | data source |
| [terraform_remote_state.tenant](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_action"></a> [action](#input\_action) | Action to perform on the Intersight Kubernetes Cluster.  Options are {Delete\|Deploy\|Ready\|Unassign}. | `string` | `"Deploy"` | no |
| <a name="input_addons_list"></a> [addons\_list](#input\_addons\_list) | List of Add-ons for Intersight Kubernetes Service.  Add-ons Options are {ccp-monitor\|kubernetes-dashboard}. | `list(string)` | `[]` | no |
| <a name="input_apikey"></a> [apikey](#input\_apikey) | Intersight API Key. | `string` | n/a | yes |
| <a name="input_cni"></a> [cni](#input\_cni) | Supported CNI type. Currently we only support Calico.<br>* Calico - Calico CNI plugin as described in:<br> https://github.com/projectcalico/cni-plugin. | `string` | `"Calico"` | no |
| <a name="input_control_plane_desired_size"></a> [control\_plane\_desired\_size](#input\_control\_plane\_desired\_size) | K8S Control Plane Desired Cluster Size. | `string` | `1` | no |
| <a name="input_control_plane_instance_type"></a> [control\_plane\_instance\_type](#input\_control\_plane\_instance\_type) | K8S Control Plane Virtual Machine Instance Type.  Options are {small\|medium\|large}. | `string` | `"small"` | no |
| <a name="input_control_plane_max_size"></a> [control\_plane\_max\_size](#input\_control\_plane\_max\_size) | K8S Control Plane Maximum Cluster Size. | `string` | `1` | no |
| <a name="input_docker_no_proxy"></a> [docker\_no\_proxy](#input\_docker\_no\_proxy) | Docker no proxy list, when using internet proxy.  Default is no list. | `list(string)` | `[]` | no |
| <a name="input_ip_pool"></a> [ip\_pool](#input\_ip\_pool) | Intersight Kubernetes Service IP Pool.  Default name is {cluster\_name}\_ip\_pool | `string` | `""` | no |
| <a name="input_ip_pool_from"></a> [ip\_pool\_from](#input\_ip\_pool\_from) | IP Pool Starting IP last Octet.  The var.network\_prefix will be combined with ip\_pool\_from for the Starting Address. | `string` | `"20"` | no |
| <a name="input_ip_pool_gateway"></a> [ip\_pool\_gateway](#input\_ip\_pool\_gateway) | IP Pool Gateway last Octet.  The var.network\_prefix will be combined with ip\_pool\_gateway for the Gateway Address. | `string` | `"254"` | no |
| <a name="input_ip_pool_netmask"></a> [ip\_pool\_netmask](#input\_ip\_pool\_netmask) | IP Pool Netmask. | `string` | `"255.255.255.0"` | no |
| <a name="input_ip_pool_size"></a> [ip\_pool\_size](#input\_ip\_pool\_size) | IP Pool Block Size. | `string` | `"30"` | no |
| <a name="input_k8s_addon_policy"></a> [k8s\_addon\_policy](#input\_k8s\_addon\_policy) | Kubernetes Addon Policy Name.  Default name is {cluster\_name}\_addon. | `string` | `""` | no |
| <a name="input_k8s_pod_cidr"></a> [k8s\_pod\_cidr](#input\_k8s\_pod\_cidr) | Pod CIDR Block to be used to assign Pod IP Addresses. | `string` | `"100.65.0.0/16"` | no |
| <a name="input_k8s_runtime_policy"></a> [k8s\_runtime\_policy](#input\_k8s\_runtime\_policy) | Kubernetes Runtime Policy Name.  Default name is {cluster\_name}\_runtime. | `string` | `""` | no |
| <a name="input_k8s_service_cidr"></a> [k8s\_service\_cidr](#input\_k8s\_service\_cidr) | Service CIDR Block used to assign Cluster Service IP Addresses. | `string` | `"100.64.0.0/16"` | no |
| <a name="input_k8s_trusted_registry"></a> [k8s\_trusted\_registry](#input\_k8s\_trusted\_registry) | Kubernetes Trusted Registry Policy Name.  Default name is {cluster\_name}\_registry. | `string` | `""` | no |
| <a name="input_k8s_version"></a> [k8s\_version](#input\_k8s\_version) | Kubernetes Version to Deploy. | `string` | `"1.19.5"` | no |
| <a name="input_k8s_version_policy"></a> [k8s\_version\_policy](#input\_k8s\_version\_policy) | Kubernetes Version Policy Name.  Default name is {cluster\_name}-k8s-version. | `string` | `""` | no |
| <a name="input_k8s_vm_infra_policy"></a> [k8s\_vm\_infra\_policy](#input\_k8s\_vm\_infra\_policy) | Kubernetes Virtual Machine Infrastructure Configuration Policy.  Default name is {cluster\_name}-vm-infra-config. | `string` | `""` | no |
| <a name="input_k8s_vm_network_policy"></a> [k8s\_vm\_network\_policy](#input\_k8s\_vm\_network\_policy) | Kubernetes Network/System Configuration Policy (CIDR, dns, ntp, etc.).  Default name is {cluster\_name}-sysconfig. | `string` | `""` | no |
| <a name="input_load_balancers"></a> [load\_balancers](#input\_load\_balancers) | Intersight Kubernetes Load Balancer count. | `string` | `3` | no |
| <a name="input_proxy_http_hostname"></a> [proxy\_http\_hostname](#input\_proxy\_http\_hostname) | HTTP Proxy Server Name or IP Address. | `string` | `""` | no |
| <a name="input_proxy_http_password"></a> [proxy\_http\_password](#input\_proxy\_http\_password) | Password for the HTTP Proxy Server, If required. | `string` | `""` | no |
| <a name="input_proxy_http_port"></a> [proxy\_http\_port](#input\_proxy\_http\_port) | Proxy HTTP Port. | `string` | `"8080"` | no |
| <a name="input_proxy_http_protocol"></a> [proxy\_http\_protocol](#input\_proxy\_http\_protocol) | Proxy HTTP Protocol. | `string` | `"http"` | no |
| <a name="input_proxy_http_username"></a> [proxy\_http\_username](#input\_proxy\_http\_username) | HTTP Proxy Username. | `string` | `""` | no |
| <a name="input_proxy_https_hostname"></a> [proxy\_https\_hostname](#input\_proxy\_https\_hostname) | HTTPS Proxy Server Name or IP Address. | `string` | `""` | no |
| <a name="input_proxy_https_password"></a> [proxy\_https\_password](#input\_proxy\_https\_password) | Password for the HTTPS Proxy Server, If required. | `string` | `""` | no |
| <a name="input_proxy_https_port"></a> [proxy\_https\_port](#input\_proxy\_https\_port) | Proxy HTTP Port. | `string` | `"8443"` | no |
| <a name="input_proxy_https_protocol"></a> [proxy\_https\_protocol](#input\_proxy\_https\_protocol) | Proxy HTTP Protocol. | `string` | `"https"` | no |
| <a name="input_proxy_https_username"></a> [proxy\_https\_username](#input\_proxy\_https\_username) | HTTPS Proxy Username. | `string` | `""` | no |
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
| <a name="input_vsphere_portgroup"></a> [vsphere\_portgroup](#input\_vsphere\_portgroup) | vSphere Port Group to assign the K8S Cluster Deployment. | `list` | <pre>[<br>  "VM"<br>]</pre> | no |
| <a name="input_vsphere_resource_pool"></a> [vsphere\_resource\_pool](#input\_vsphere\_resource\_pool) | vSphere Resource Pool to assign the K8S Cluster Deployment. | `string` | `""` | no |
| <a name="input_vsphere_target"></a> [vsphere\_target](#input\_vsphere\_target) | vSphere Server registered as a Target in Intersight.  The default, 210, only works if this is for the DevNet Sandbox. | `string` | `"210"` | no |
| <a name="input_worker_desired_size"></a> [worker\_desired\_size](#input\_worker\_desired\_size) | K8S Worker Desired Cluster Size. | `string` | `0` | no |
| <a name="input_worker_instance_type"></a> [worker\_instance\_type](#input\_worker\_instance\_type) | K8S Worker Virtual Machine Instance Type.  Options are {small\|medium\|large}. | `string` | `"small"` | no |
| <a name="input_worker_max_size"></a> [worker\_max\_size](#input\_worker\_max\_size) | K8S Worker Maximum Cluster Size. | `string` | `4` | no |
| <a name="input_ws_global_vars"></a> [ws\_global\_vars](#input\_ws\_global\_vars) | Global Variables Workspace Name.  The default value will be set to {prefix\_value}\_global\_vars by the tfe variable module. | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_addons_list"></a> [addons\_list](#output\_addons\_list) | List of Add-ons for Policy Creation. |
| <a name="output_control_plane_profile"></a> [control\_plane\_profile](#output\_control\_plane\_profile) | moid of the Master Node Profile. |
| <a name="output_iks_cluster"></a> [iks\_cluster](#output\_iks\_cluster) | moid of the IKS Cluster. |
| <a name="output_ip_pool"></a> [ip\_pool](#output\_ip\_pool) | IP Pool Policy Name. |
| <a name="output_ip_pool_from"></a> [ip\_pool\_from](#output\_ip\_pool\_from) | IP Pool Starting IP Value. |
| <a name="output_ip_pool_gateway"></a> [ip\_pool\_gateway](#output\_ip\_pool\_gateway) | IP Pool Gateway Value. |
| <a name="output_ip_pool_netmask"></a> [ip\_pool\_netmask](#output\_ip\_pool\_netmask) | IP Pool Netmask Value. |
| <a name="output_ip_pool_size"></a> [ip\_pool\_size](#output\_ip\_pool\_size) | IP Pool Block Size. |
| <a name="output_k8s_addon_policy"></a> [k8s\_addon\_policy](#output\_k8s\_addon\_policy) | Kubernetes Addon Policy Name. |
| <a name="output_k8s_runtime_policy"></a> [k8s\_runtime\_policy](#output\_k8s\_runtime\_policy) | Kubernetes Runtime Policy Name. |
| <a name="output_k8s_trusted_registry"></a> [k8s\_trusted\_registry](#output\_k8s\_trusted\_registry) | Kubernetes Trusted Registry Policy Name. |
| <a name="output_k8s_version_policy"></a> [k8s\_version\_policy](#output\_k8s\_version\_policy) | Kubernetes Version Policy Name. |
| <a name="output_k8s_vm_infra_policy"></a> [k8s\_vm\_infra\_policy](#output\_k8s\_vm\_infra\_policy) | Kubernetes VM Infrastructure Policy Name. |
| <a name="output_k8s_vm_network_policy"></a> [k8s\_vm\_network\_policy](#output\_k8s\_vm\_network\_policy) | Kubernetes VM Network Policy Name. |
| <a name="output_proxy_http_hostname"></a> [proxy\_http\_hostname](#output\_proxy\_http\_hostname) | HTTP Proxy Server Name or IP Address. |
| <a name="output_proxy_http_username"></a> [proxy\_http\_username](#output\_proxy\_http\_username) | HTTP Proxy Username. |
| <a name="output_proxy_https_hostname"></a> [proxy\_https\_hostname](#output\_proxy\_https\_hostname) | HTTPS Proxy Server Name or IP Address.  If Left blank, and proxy\_http\_hostname is defined, it will be copied to here. |
| <a name="output_proxy_https_username"></a> [proxy\_https\_username](#output\_proxy\_https\_username) | HTTPS Proxy Username. |
| <a name="output_vsphere_target"></a> [vsphere\_target](#output\_vsphere\_target) | vSphere Target. |
| <a name="output_worker_profile"></a> [worker\_profile](#output\_worker\_profile) | moid of the Worker Node Profile. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

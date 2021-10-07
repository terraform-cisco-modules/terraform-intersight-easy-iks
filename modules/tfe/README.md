# Workspace and Variable Creation

## VERY IMPORTANT NOTE: This provider stores terraform state in plain text.  Do not remove the .gitignore that is protecting you from uploading the state files in the root folder

## Obtain tokens and keys

Follow the base repository instructions to obtain values for the following variables:

### Terraform Cloud Variables

* terraform_cloud_token

  instructions: <https://www.terraform.io/docs/cloud/users-teams-organizations/api-tokens.html>

* tfc_oauth_token

  instructions: <https://www.terraform.io/docs/cloud/vcs/index.html>

* tfc_organization (TFCB Organization Name)
* tfc_email (Must be an Email Assigned to the TFCB Account)
* agent_pool (The Name of the Agent Pool in the TFCB Account)
* vcs_repo (The Name of your Version Control Repository. i.e. CiscoDevNet/intersight-tfb-iks)

### Intersight Variables

* apikey
* secretkey

  instructions: <https://community.cisco.com/t5/data-center-documents/intersight-api-overview/ta-p/3651994>

### When assigning the vSphere Password - It Must match the password used to register the Target in Intersight

* k8s_vm_infra_password

### Generate SSH Key

* ssh_key (Note this must be a ecdsa key type)

  instructions: <https://www.ssh.com/academy/ssh/keygen>

### Import the Variables into your Environment before Running the Terraform Cloud Provider module(s) in this directory

Modify the terraform.tfvars file to the unique attributes of your environment

Once finished with the modification commit the changes to your reposotiry.

The Following examples are for a Linux based Operating System.  Note that the TF_VAR_ prefix is used as a notification to the terraform engine that the environment variable will be consumed by terraform.

* Terraform Cloud Variables

```bash
export TF_VAR_terraform_cloud_token="your_cloud_token"
export TF_VAR_tfc_oauth_token="your_oath_token"
```

* Intersight apikey and secretkey

```bash
export TF_VAR_apikey="your_api_key"
export TF_VAR_secretkey=`../../../../intersight_secretkey.txt`
```

* vSphere Password

```bash
export TF_VAR_k8s_vm_infra_password="your_vshpere_password"
```

* Kubernetes Cluster ssh_key

```bash
export TF_VAR_ssh_key_1="your_ssh_key"
```

Once all Variables have been imported into your environment, run the plan in the tfe folder:

```bash
terraform plan -out=main.plan
terraform apply main.plan
```

When run, this module will Create the Terraform Cloud Workspace(s) and Assign the Variables to the workspace(s).

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_tfe"></a> [tfe](#requirement\_tfe) | 0.25.3 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_app_variables"></a> [app\_variables](#module\_app\_variables) | terraform-cisco-modules/modules/tfe//modules/tfc_variables | n/a |
| <a name="module_app_workspaces"></a> [app\_workspaces](#module\_app\_workspaces) | terraform-cisco-modules/modules/tfe//modules/tfc_workspace | n/a |
| <a name="module_iks_variables"></a> [iks\_variables](#module\_iks\_variables) | terraform-cisco-modules/modules/tfe//modules/tfc_variables | n/a |
| <a name="module_intersight_global_variables"></a> [intersight\_global\_variables](#module\_intersight\_global\_variables) | terraform-cisco-modules/modules/tfe//modules/tfc_variables | n/a |
| <a name="module_iwo_variables"></a> [iwo\_variables](#module\_iwo\_variables) | terraform-cisco-modules/modules/tfe//modules/tfc_variables | n/a |
| <a name="module_iwo_workspaces"></a> [iwo\_workspaces](#module\_iwo\_workspaces) | terraform-cisco-modules/modules/tfe//modules/tfc_workspace | n/a |
| <a name="module_k8s_policies_variables"></a> [k8s\_policies\_variables](#module\_k8s\_policies\_variables) | terraform-cisco-modules/modules/tfe//modules/tfc_variables | n/a |
| <a name="module_kubeconfig_variables"></a> [kubeconfig\_variables](#module\_kubeconfig\_variables) | terraform-cisco-modules/modules/tfe//modules/tfc_variables | n/a |
| <a name="module_kubeconfig_workspaces"></a> [kubeconfig\_workspaces](#module\_kubeconfig\_workspaces) | terraform-cisco-modules/modules/tfe//modules/tfc_workspace | n/a |
| <a name="module_tfc_agent_pool"></a> [tfc\_agent\_pool](#module\_tfc\_agent\_pool) | terraform-cisco-modules/modules/tfe//modules/tfc_agent_pool | n/a |
| <a name="module_workspaces"></a> [workspaces](#module\_workspaces) | terraform-cisco-modules/modules/tfe//modules/tfc_workspace | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_agent_pool"></a> [agent\_pool](#input\_agent\_pool) | Terraform Cloud Agent Pool. | `string` | n/a | yes |
| <a name="input_apikey"></a> [apikey](#input\_apikey) | Intersight API Key. | `string` | n/a | yes |
| <a name="input_endpoint"></a> [endpoint](#input\_endpoint) | Intersight URL. | `string` | `"https://intersight.com"` | no |
| <a name="input_iks_cluster"></a> [iks\_cluster](#input\_iks\_cluster) | Intersight Kubernetes Service Cluster Profile Variable Map.<br>* action\_cluster - Action to perform on the Kubernetes Cluster.  Options are {Delete\|Deploy\|Ready\|No-op\|Unassign}.<br>* action\_control\_plane - Action to perform on the Kubernetes Control Plane Nodes.  Options are {Delete\|Deploy\|Ready\|No-op\|Unassign}.<br>* action\_worker - Action to perform on the Kubernetes Worker Nodes.  Options are {Delete\|Deploy\|Ready\|No-op\|Unassign}.<br>* control\_plane\_desired\_size - Desired number of control plane nodes in this node group, same as minsize initially and is updated by the auto-scaler.  Options are {1\|3}.<br>* control\_plane\_k8s\_labels - List of key/value Attributes to Assign to the control plane node configuration.<br>* control\_plane\_max\_size - Maximum number of control plane nodes desired in this node group.  Range is 1-128.<br>* description - A description for the policy.<br>* ip\_pool\_moid - Name of the IP Pool to assign to Cluster and Node Profiles.<br>* k8s\_addon\_policy\_moid - Names of the Kubernetes Add-ons to add to the cluster.  Options are {ccp-monitor\|kubernetes-dashboard} or [].<br>* k8s\_network\_cidr\_moid - Name of the Kubneretes Network CIDR Policy to assign to Cluster.<br>* k8s\_nodeos\_config\_moid - Name of the Kubneretes Node OS Config Policy to assign to Cluster and Node Profiles.<br>* k8s\_registry\_moid - Name of the Kubernetes Trusted Registry Policy to assign to Cluster and Node Profiles<br>* k8s\_runtime\_moid - Name of the Kubernetes Runtime Policy to assign to Cluster and Node Profiles.<br>* k8s\_version\_moid - Name of the Kubernetes Version Policy to assign to the Node Profiles.<br>* k8s\_vm\_infra\_moid - Name of the Kubernetes Virtual Machine Infra Config Policy to assign to the Node Profiles.<br>* k8s\_vm\_instance\_type\_ctrl\_plane - Name of the Kubernetes Virtual Machine Instance Type Policy to assign to control plane nodes.<br>* k8s\_vm\_instance\_type\_worker - Name of the Kubernetes Virtual Machine Instance Type Policy to assign to worker nodes.<br>* load\_balancers - Number of load balancer addresses to deploy. Range is 1-999.<br>* organization - Name of the Intersight Organization to assign this pool to.  https://intersight.com/an/settings/organizations/<br>* ssh\_key - The SSH Key Name should be ssh\_key\_{1\|2\|3\|4\|5}.  This will point to the ssh\_key variable that will be used.<br>* ssh\_user - SSH Username for node login.<br>* tags - tags - List of key/value Attributes to Assign to the Profile.<br>* wait\_for\_complete - This model object can trigger workflows. Use this option to wait for all running workflows to reach a complete state.<br>* worker\_desired\_size - Desired number of nodes in this worker node group, same as minsize initially and is updated by the auto-scaler.  Range is 1-128.<br>* worker\_k8s\_labels - List of key/value Attributes to Assign to the worker node configuration.<br>* worker\_max\_size - Maximum number of worker nodes desired in this node group.  Range is 1-128. | <pre>map(object(<br>    {<br>      action_cluster                  = optional(string)<br>      action_control_plane            = optional(string)<br>      action_worker                   = optional(string)<br>      control_plane_desired_size      = optional(number)<br>      control_plane_k8s_labels        = optional(list(map(string)))<br>      control_plane_max_size          = optional(number)<br>      description                     = optional(string)<br>      ip_pool_moid                    = string<br>      k8s_addon_policy_moid           = optional(set(string))<br>      k8s_network_cidr_moid           = string<br>      k8s_nodeos_config_moid          = string<br>      k8s_registry_moid               = optional(string)<br>      k8s_runtime_moid                = optional(string)<br>      k8s_version_moid                = string<br>      k8s_vm_infra_moid               = string<br>      k8s_vm_instance_type_ctrl_plane = string<br>      k8s_vm_instance_type_worker     = string<br>      load_balancers                  = optional(number)<br>      organization                    = optional(string)<br>      ssh_key                         = string<br>      ssh_user                        = string<br>      tags                            = optional(list(map(string)))<br>      wait_for_complete               = optional(bool)<br>      worker_desired_size             = optional(number)<br>      worker_k8s_labels               = optional(list(map(string)))<br>      worker_max_size                 = optional(number)<br>    }<br>  ))</pre> | <pre>{<br>  "default": {<br>    "action_cluster": "Deploy",<br>    "action_control_plane": "No-op",<br>    "action_worker": "No-op",<br>    "control_plane_desired_size": 1,<br>    "control_plane_k8s_labels": [],<br>    "control_plane_max_size": 3,<br>    "description": "",<br>    "ip_pool_moid": "**REQUIRED**",<br>    "k8s_addon_policy_moid": [],<br>    "k8s_network_cidr_moid": "**REQUIRED**",<br>    "k8s_nodeos_config_moid": "**REQUIRED**",<br>    "k8s_registry_moid": "",<br>    "k8s_runtime_moid": "",<br>    "k8s_version_moid": "**REQUIRED**",<br>    "k8s_vm_infra_moid": "**REQUIRED**",<br>    "k8s_vm_instance_type_ctrl_plane": "**REQUIRED**",<br>    "k8s_vm_instance_type_worker": "**REQUIRED**",<br>    "load_balancers": 3,<br>    "organization": "default",<br>    "ssh_key": "ssh_key_1",<br>    "ssh_user": "iksadmin",<br>    "tags": [],<br>    "wait_for_complete": false,<br>    "worker_desired_size": 0,<br>    "worker_k8s_labels": [],<br>    "worker_max_size": 4<br>  }<br>}</pre> | no |
| <a name="input_ip_pools"></a> [ip\_pools](#input\_ip\_pools) | key - Name of the IP Pool.<br>* Assignment order decides the order in which the next identifier is allocated.<br>  - default - (Default) Assignment order is decided by the system.<br>  - sequential - Identifiers are assigned in a sequential order.<br>* description - Description to Assign to the Pool.<br>* ipv4\_block - Map of Addresses to Assign to the Pool.<br>  - pool\_size - Size of the IPv4 Address Block.<br>  - starting\_ip - Starting IPv4 Address.<br>  - primary\_dns = Primary DNS Server to Assign to the Pool<br>  - secondary\_dns = Secondary DNS Server to Assign to the Pool<br>* ipv4\_config - IPv4 Configuration to assign to the ipv4\_blocks.<br>  - gateway - Gateway to assign to the pool.<br>  - netmask - Netmask to assign to the pool.<br>* ipv6\_block - Map of Addresses to Assign to the Pool.<br>  - from - Starting IPv6 Address.<br>  - size - Size of the IPv6 Address Block.<br>* ipv6\_config - IPv6 Configuration to assign to the ipv6\_blocks.<br>  - gateway - Gateway to assign to the pool.<br>  - netmask - Netmask to assign to the pool.<br>  - primary\_dns = Primary DNS Server to Assign to the Pool<br>  - secondary\_dns = Secondary DNS Server to Assign to the Pool<br>* organization - Name of the Intersight Organization to assign this pool to.  Default is default.<br>  - https://intersight.com/an/settings/organizations/<br>* tags - List of Key/Value Pairs to Assign as Attributes to the Pool. | <pre>map(object(<br>    {<br>      assignment_order = optional(string)<br>      description      = optional(string)<br>      ipv4_block       = optional(list(map(string)))<br>      ipv4_config = optional(map(object(<br>        {<br>          gateway       = string<br>          netmask       = string<br>          primary_dns   = optional(string)<br>          secondary_dns = optional(string)<br>        }<br>      )))<br>      ipv6_block = optional(list(map(string)))<br>      ipv6_config = optional(map(object(<br>        {<br>          gateway       = string<br>          prefix        = number<br>          primary_dns   = optional(string)<br>          secondary_dns = optional(string)<br>        }<br>      )))<br>      organization = optional(string)<br>      tags         = optional(list(map(string)))<br>    }<br>  ))</pre> | <pre>{<br>  "default": {<br>    "assignment_order": "default",<br>    "description": "",<br>    "ipv4_block": [],<br>    "ipv4_config": {},<br>    "ipv6_block": [],<br>    "ipv6_config": {},<br>    "organization": "default",<br>    "tags": []<br>  }<br>}</pre> | no |
| <a name="input_k8s_addon_policies"></a> [k8s\_addon\_policies](#input\_k8s\_addon\_policies) | Intersight Kubernetes Service Add-ons Variable Map.  Add-ons Options are {ccp-monitor\|kubernetes-dashboard} currently.<br>* description - A description for the policy.<br>* install\_strategy - Addon install strategy to determine whether an addon is installed if not present.<br>  - None - Unspecified install strategy.<br>  - NoAction - No install action performed.<br>  - InstallOnly - Only install in green field. No action in case of failure or removal.<br>  - Always - Attempt install if chart is not already installed.<br>* organization - Name of the Intersight Organization to assign this pool to.  https://intersight.com/an/settings/organizations/<br>* release\_name - Name for the helm release.<br>* release\_namespace - Namespace for the helm release.<br>* tags - List of key/value Attributes to Assign to the Policy.<br>* upgrade\_strategy - Addon upgrade strategy to determine whether an addon configuration is overwritten on upgrade.<br>  - None - Unspecified upgrade strategy.<br>  - NoAction - This choice enables No upgrades to be performed.<br>  - UpgradeOnly - Attempt upgrade if chart or overrides options change, no action on upgrade failure.<br>  - ReinstallOnFailure - Attempt upgrade first. Remove and install on upgrade failure.<br>  - AlwaysReinstall - Always remove older release and reinstall. | <pre>map(object(<br>    {<br>      description       = optional(string)<br>      install_strategy  = optional(string)<br>      organization      = optional(string)<br>      release_name      = optional(string)<br>      release_namespace = optional(string)<br>      tags              = optional(list(map(string)))<br>      upgrade_strategy  = optional(string)<br>    }<br>  ))</pre> | <pre>{<br>  "default": {<br>    "description": "",<br>    "install_strategy": "Always",<br>    "organization": "default",<br>    "release_name": "",<br>    "release_namespace": "",<br>    "tags": [],<br>    "upgrade_strategy": "UpgradeOnly"<br>  }<br>}</pre> | no |
| <a name="input_k8s_network_cidr"></a> [k8s\_network\_cidr](#input\_k8s\_network\_cidr) | Intersight Kubernetes Network CIDR Policy Variable Map.<br>* cidr\_pod - CIDR block to allocate pod network IP addresses from.<br>* cidr\_service - Pod CIDR Block to be used to assign Pod IP Addresses.<br>* cni\_type - Supported CNI type. Currently we only support Calico.<br>  - Calico - Calico CNI plugin as described in https://github.com/projectcalico/cni-plugin<br>  - Aci - Cisco ACI Container Network Interface plugin.<br>* description - A description for the policy.<br>* organization - Name of the Intersight Organization to assign this pool to.  https://intersight.com/an/settings/organizations/<br>* tags - tags - List of key/value Attributes to Assign to the Policy. | <pre>map(object(<br>    {<br>      cidr_pod     = optional(string)<br>      cidr_service = optional(string)<br>      cni_type     = optional(string)<br>      description  = optional(string)<br>      organization = optional(string)<br>      tags         = optional(list(map(string)))<br>    }<br>  ))</pre> | <pre>{<br>  "default": {<br>    "cidr_pod": "100.64.0.0/16",<br>    "cidr_service": "100.65.0.0/16",<br>    "cni_type": "Calico",<br>    "description": "",<br>    "organization": "default",<br>    "tags": []<br>  }<br>}</pre> | no |
| <a name="input_k8s_nodeos_config"></a> [k8s\_nodeos\_config](#input\_k8s\_nodeos\_config) | Intersight Kubernetes Node OS Configuration Policy Variable Map.<br>* description - A description for the policy.<br>* dns\_servers\_v4 - DNS Servers for the Kubernetes Node OS Configuration Policy.<br>* domain\_name - Domain Name for the Kubernetes Node OS Configuration Policy.<br>* ntp\_servers - NTP Servers for the Kubernetes Node OS Configuration Policy.<br>* organization - Name of the Intersight Organization to assign this pool to.  https://intersight.com/an/settings/organizations/<br>* tags - tags - List of key/value Attributes to Assign to the Policy.<br>* timezone - The timezone of the node's system clock.  For a List of supported timezones see the following URL. https://github.com/terraform-cisco-modules/terraform-intersight-imm/blob/master/modules/policies_ntp/README.md. | <pre>map(object(<br>    {<br>      description    = optional(string)<br>      dns_servers_v4 = optional(list(string))<br>      domain_name    = optional(string)<br>      ntp_servers    = optional(list(string))<br>      organization   = optional(string)<br>      tags           = optional(list(map(string)))<br>      timezone       = optional(string)<br>    }<br>  ))</pre> | <pre>{<br>  "default": {<br>    "description": "",<br>    "dns_servers_v4": [<br>      "208.67.220.220",<br>      "208.67.222.222"<br>    ],<br>    "domain_name": "example.com",<br>    "ntp_servers": [],<br>    "organization": "default",<br>    "tags": [],<br>    "timezone": "Etc/GMT"<br>  }<br>}</pre> | no |
| <a name="input_k8s_runtime_create"></a> [k8s\_runtime\_create](#input\_k8s\_runtime\_create) | Flag to specify if the Kubernetes Runtime Policy should be created or not. | `bool` | `false` | no |
| <a name="input_k8s_runtime_http_password"></a> [k8s\_runtime\_http\_password](#input\_k8s\_runtime\_http\_password) | Password for the HTTP Proxy Server, If required. | `string` | `""` | no |
| <a name="input_k8s_runtime_https_password"></a> [k8s\_runtime\_https\_password](#input\_k8s\_runtime\_https\_password) | Password for the HTTPS Proxy Server, If required. | `string` | `""` | no |
| <a name="input_k8s_runtime_policies"></a> [k8s\_runtime\_policies](#input\_k8s\_runtime\_policies) | Intersight Kubernetes Runtime Policy Variable Map.<br>* description - A description for the policy.<br>* docker\_bridge\_cidr - The CIDR for docker bridge network. This address space must not collide with other CIDRs on your networks, including the cluster's service CIDR, pod CIDR and IP Pools.<br>* docker\_no\_proxy - Docker no proxy list, when using internet proxy.<br>* http\_hostname - Hostname of the HTTP Proxy Server.<br>* http\_port - HTTP Proxy Port.  Range is 1-65535.<br>* http\_protocol - HTTP Proxy Protocol. Options are {http\|https}.<br>* http\_username - Username for the HTTP Proxy Server.<br>* https\_hostname - Hostname of the HTTPS Proxy Server.<br>* https\_port - HTTPS Proxy Port.  Range is 1-65535<br>* https\_protocol - HTTPS Proxy Protocol. Options are {http\|https}.<br>* https\_username - Username for the HTTPS Proxy Server.<br>* organization - Name of the Intersight Organization to assign this pool to.  https://intersight.com/an/settings/organizations/<br>* tags - List of key/value Attributes to Assign to the Policy. | <pre>map(object(<br>    {<br>      description        = optional(string)<br>      docker_bridge_cidr = optional(string)<br>      docker_no_proxy    = optional(list(string))<br>      http_hostname      = optional(string)<br>      http_port          = optional(number)<br>      http_protocol      = optional(string)<br>      http_username      = optional(string)<br>      https_hostname     = optional(string)<br>      https_port         = optional(number)<br>      https_protocol     = optional(string)<br>      https_username     = optional(string)<br>      organization       = optional(string)<br>      tags               = optional(list(map(string)))<br>    }<br>  ))</pre> | <pre>{<br>  "default": {<br>    "description": "",<br>    "docker_bridge_cidr": "",<br>    "docker_no_proxy": [],<br>    "http_hostname": "",<br>    "http_port": 8080,<br>    "http_protocol": "http",<br>    "http_username": "",<br>    "https_hostname": "",<br>    "https_port": 8443,<br>    "https_protocol": "https",<br>    "https_username": "",<br>    "organization": "default",<br>    "tags": []<br>  }<br>}</pre> | no |
| <a name="input_k8s_trusted_create"></a> [k8s\_trusted\_create](#input\_k8s\_trusted\_create) | Flag to specify if the Kubernetes Runtime Policy should be created or not. | `bool` | `false` | no |
| <a name="input_k8s_trusted_registries"></a> [k8s\_trusted\_registries](#input\_k8s\_trusted\_registries) | Intersight Kubernetes Trusted Registry Policy Variable Map.<br>* description - A description for the policy.<br>* organization - Name of the Intersight Organization to assign this pool to.  https://intersight.com/an/settings/organizations/<br>* root\_ca - List of root CA Signed Registries.<br>* tags - List of key/value Attributes to Assign to the Policy.<br>* unsigned - List of unsigned registries to be supported. | <pre>map(object(<br>    {<br>      description  = optional(string)<br>      organization = optional(string)<br>      root_ca      = optional(list(string))<br>      tags         = optional(list(map(string)))<br>      unsigned     = optional(list(string))<br>    }<br>  ))</pre> | <pre>{<br>  "default": {<br>    "description": "",<br>    "organization": "default",<br>    "root_ca": [],<br>    "tags": [],<br>    "unsigned": []<br>  }<br>}</pre> | no |
| <a name="input_k8s_version_policies"></a> [k8s\_version\_policies](#input\_k8s\_version\_policies) | Intersight Kubernetes Version Policy Variable Map.<br>* description - A description for the policy.<br>* organization - Name of the Intersight Organization to assign this pool to.  https://intersight.com/an/settings/organizations/<br>* tags - List of key/value Attributes to Assign to the Policy.<br>* version - Desired Kubernetes version.  Options are {1.19.5} | <pre>map(object(<br>    {<br>      description  = optional(string)<br>      organization = optional(string)<br>      tags         = optional(list(map(string)))<br>      version      = optional(string)<br>    }<br>  ))</pre> | <pre>{<br>  "default": {<br>    "description": "",<br>    "organization": "default",<br>    "tags": [],<br>    "version": "1.19.5"<br>  }<br>}</pre> | no |
| <a name="input_k8s_vm_infra_config"></a> [k8s\_vm\_infra\_config](#input\_k8s\_vm\_infra\_config) | Intersight Kubernetes Virtual Machine Infra Config Policy Variable Map.<br>* description - A description for the policy.<br>* organization - Name of the Intersight Organization to assign this pool to.  https://intersight.com/an/settings/organizations/<br>* tags - List of key/value Attributes to Assign to the Policy.<br>* vsphere\_cluster - vSphere Cluster to assign the K8S Cluster Deployment.<br>* vsphere\_datastore - vSphere Datastore to assign the K8S Cluster Deployment.r\n<br>* vsphere\_portgroup - vSphere Port Group to assign the K8S Cluster Deployment.r\n<br>* vsphere\_resource\_pool - vSphere Resource Pool to assign the K8S Cluster Deployment.r\n<br>* vsphere\_target - Name of the vSphere Target discovered in Intersight, to provision the cluster on. | <pre>map(object(<br>    {<br>      description           = optional(string)<br>      organization          = optional(string)<br>      tags                  = optional(list(map(string)))<br>      vsphere_cluster       = string<br>      vsphere_datastore     = string<br>      vsphere_portgroup     = list(string)<br>      vsphere_resource_pool = optional(string)<br>      vsphere_target        = string<br>    }<br>  ))</pre> | <pre>{<br>  "default": {<br>    "description": "",<br>    "organization": "default",<br>    "tags": [],<br>    "vsphere_cluster": "default",<br>    "vsphere_datastore": "datastore1",<br>    "vsphere_portgroup": [<br>      "VM Network"<br>    ],<br>    "vsphere_resource_pool": "",<br>    "vsphere_target": ""<br>  }<br>}</pre> | no |
| <a name="input_k8s_vm_infra_password"></a> [k8s\_vm\_infra\_password](#input\_k8s\_vm\_infra\_password) | vSphere Password.  Note: this is the password of the Credentials used to register the vSphere Target. | `string` | n/a | yes |
| <a name="input_k8s_vm_instance_type"></a> [k8s\_vm\_instance\_type](#input\_k8s\_vm\_instance\_type) | Intersight Kubernetes Node OS Configuration Policy Variable Map.  Name of the policy will be {organization}\_{each.key}.<br>* cpu - Number of CPUs allocated to virtual machine.  Range is 1-40.<br>* description - A description for the policy.<br>* disk - Ephemeral disk capacity to be provided with units example - 10 for 10 Gigabytes.<br>* memory - Virtual machine memory defined in mebibytes (MiB).  Range is 1-4177920.<br>* organization - Name of the Intersight Organization to assign this pool to.  https://intersight.com/an/settings/organizations/<br>* tags - List of key/value Attributes to Assign to the Policy. | <pre>map(object(<br>    {<br>      cpu          = optional(number)<br>      description  = optional(string)<br>      disk         = optional(number)<br>      memory       = optional(number)<br>      organization = optional(string)<br>      tags         = optional(list(map(string)))<br>    }<br>  ))</pre> | <pre>{<br>  "default": {<br>    "cpu": 4,<br>    "description": "",<br>    "disk": 40,<br>    "memory": 16384,<br>    "organization": "default",<br>    "tags": []<br>  }<br>}</pre> | no |
| <a name="input_organizations"></a> [organizations](#input\_organizations) | Intersight Organization Names to Apply Policy to.  https://intersight.com/an/settings/organizations/. | `set(string)` | <pre>[<br>  "default"<br>]</pre> | no |
| <a name="input_secretkey"></a> [secretkey](#input\_secretkey) | Intersight Secret Key. | `string` | n/a | yes |
| <a name="input_ssh_key_1"></a> [ssh\_key\_1](#input\_ssh\_key\_1) | Intersight Kubernetes Service Cluster SSH Public Key 1. | `string` | `""` | no |
| <a name="input_ssh_key_2"></a> [ssh\_key\_2](#input\_ssh\_key\_2) | Intersight Kubernetes Service Cluster SSH Public Key 2.  These are place holders for Clusters that use different keys for different clusters. | `string` | `""` | no |
| <a name="input_ssh_key_3"></a> [ssh\_key\_3](#input\_ssh\_key\_3) | Intersight Kubernetes Service Cluster SSH Public Key 3.  These are place holders for Clusters that use different keys for different clusters. | `string` | `""` | no |
| <a name="input_ssh_key_4"></a> [ssh\_key\_4](#input\_ssh\_key\_4) | Intersight Kubernetes Service Cluster SSH Public Key 4.  These are place holders for Clusters that use different keys for different clusters. | `string` | `""` | no |
| <a name="input_ssh_key_5"></a> [ssh\_key\_5](#input\_ssh\_key\_5) | Intersight Kubernetes Service Cluster SSH Public Key 5.  These are place holders for Clusters that use different keys for different clusters. | `string` | `""` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to be Associated with Objects Created in Intersight. | `list(map(string))` | `[]` | no |
| <a name="input_terraform_cloud_token"></a> [terraform\_cloud\_token](#input\_terraform\_cloud\_token) | Token to Authenticate to the Terraform Cloud. | `string` | n/a | yes |
| <a name="input_terraform_version"></a> [terraform\_version](#input\_terraform\_version) | Terraform Target Version. | `string` | `"1.0.0"` | no |
| <a name="input_tfc_oauth_token"></a> [tfc\_oauth\_token](#input\_tfc\_oauth\_token) | Terraform Cloud OAuth Token for VCS\_Repo Integration. | `string` | n/a | yes |
| <a name="input_tfc_organization"></a> [tfc\_organization](#input\_tfc\_organization) | Terraform Cloud Organization Name. | `string` | n/a | yes |
| <a name="input_vcs_repo"></a> [vcs\_repo](#input\_vcs\_repo) | Version Control System Repository. | `string` | n/a | yes |
| <a name="input_workspaces"></a> [workspaces](#input\_workspaces) | Map of Workspaces to create in Terraform Cloud.<br>key - Name of the Workspace to Create.<br>* auto\_apply - Terraform Apply occur without a confirmation; after a successful plan.<br>* cluster\_name - Use this variable for the IKS Cluster Workspace if the Workspace Name != Cluster Name.<br>* create\_app\_hello - Use this variable to tell the script to create the app\_hello workspace or not.<br>* create\_iwo - Use this variable to tell the script to create the iwo workspace or not.<br>* description - A Description for the Workspace.<br>* working\_directory - The Directory of the Version Control Repository that contains the Terraform code for UCS Domain Profiles for this Workspace.<br>* workspace\_type - What Type of Workspace will this Create.  Options are:<br>  - iks<br>  - k8s\_policies | <pre>map(object(<br>    {<br>      auto_apply        = optional(bool)<br>      cluster_name      = optional(string)<br>      create_app_hello  = optional(bool)<br>      create_iwo        = optional(bool)<br>      description       = optional(string)<br>      working_directory = optional(string)<br>      workspace_type    = optional(string)<br>    }<br>  ))</pre> | <pre>{<br>  "default": {<br>    "auto_apply": true,<br>    "cluster_name": "",<br>    "create_app_hello": false,<br>    "create_iwo": false,<br>    "description": "",<br>    "working_directory": "modules/k8s_policies",<br>    "workspace_type": "k8s_policies"<br>  }<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_app_workspaces"></a> [app\_workspaces](#output\_app\_workspaces) | Terraform Cloud App Hello Workspace IDs and Names. |
| <a name="output_iwo_workspaces"></a> [iwo\_workspaces](#output\_iwo\_workspaces) | Terraform Cloud IWO Workspace IDs and Names. |
| <a name="output_kubeconfig_workspaces"></a> [kubeconfig\_workspaces](#output\_kubeconfig\_workspaces) | Terraform Cloud kubeconfig Workspace IDs and Names. |
| <a name="output_tfc_agent_pool"></a> [tfc\_agent\_pool](#output\_tfc\_agent\_pool) | Terraform Cloud Agent Pool ID. |
| <a name="output_workspaces"></a> [workspaces](#output\_workspaces) | Terraform Cloud Workspace IDs and Names. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

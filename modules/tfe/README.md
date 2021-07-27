# Workspace and Variable Creation

## VERY IMPORTANT NOTE: This provider stores terraform state in plain text.  Do not remove the .gitignore that is protecting you from uploading the state files

## Obtain tokens and keys

Follow the base repository instructions to obtain values for the following variables:

### Terraform Cloud Variables

* terraform_cloud_token

  instructions: <https://www.terraform.io/docs/cloud/users-teams-organizations/api-tokens.html>

* tfc_oath_token

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

* vsphere_password

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
export TF_VAR_tfc_oath_token="your_oath_token"
```

* Intersight apikey and secretkey

```bash
export TF_VAR_apikey="your_api_key"
export TF_VAR_secretkey=`../../../../intersight_secretkey.txt`
```

* vSphere Password

```bash
export TF_VAR_vsphere_password="your_vshpere_password"
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
| <a name="module_app_hello_variables"></a> [app\_hello\_variables](#module\_app\_hello\_variables) | terraform-cisco-modules/modules/tfe//modules/tfc_variables | n/a |
| <a name="module_app_hello_workspaces"></a> [app\_hello\_workspaces](#module\_app\_hello\_workspaces) | terraform-cisco-modules/modules/tfe//modules/tfc_workspace | n/a |
| <a name="module_iks_variables"></a> [iks\_variables](#module\_iks\_variables) | terraform-cisco-modules/modules/tfe//modules/tfc_variables | n/a |
| <a name="module_iks_workspaces"></a> [iks\_workspaces](#module\_iks\_workspaces) | terraform-cisco-modules/modules/tfe//modules/tfc_workspace | n/a |
| <a name="module_iwo_variables"></a> [iwo\_variables](#module\_iwo\_variables) | terraform-cisco-modules/modules/tfe//modules/tfc_variables | n/a |
| <a name="module_iwo_workspaces"></a> [iwo\_workspaces](#module\_iwo\_workspaces) | terraform-cisco-modules/modules/tfe//modules/tfc_workspace | n/a |
| <a name="module_kube_variables"></a> [kube\_variables](#module\_kube\_variables) | terraform-cisco-modules/modules/tfe//modules/tfc_variables | n/a |
| <a name="module_kube_workspaces"></a> [kube\_workspaces](#module\_kube\_workspaces) | terraform-cisco-modules/modules/tfe//modules/tfc_workspace | n/a |
| <a name="module_org_variables"></a> [org\_variables](#module\_org\_variables) | terraform-cisco-modules/modules/tfe//modules/tfc_variables | n/a |
| <a name="module_org_workspace"></a> [org\_workspace](#module\_org\_workspace) | terraform-cisco-modules/modules/tfe//modules/tfc_workspace | n/a |
| <a name="module_tfc_agent_pool"></a> [tfc\_agent\_pool](#module\_tfc\_agent\_pool) | terraform-cisco-modules/modules/tfe//modules/tfc_agent_pool | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_agent_pool"></a> [agent\_pool](#input\_agent\_pool) | Terraform Cloud Agent Pool. | `string` | n/a | yes |
| <a name="input_apikey"></a> [apikey](#input\_apikey) | Intersight API Key. | `string` | n/a | yes |
| <a name="input_dns_servers_v4"></a> [dns\_servers\_v4](#input\_dns\_servers\_v4) | DNS Servers for Kubernetes Sysconfig Policy. | `list(string)` | <pre>[<br>  "198.18.0.100",<br>  "198.18.0.101"<br>]</pre> | no |
| <a name="input_endpoint"></a> [endpoint](#input\_endpoint) | Intersight URL. | `string` | `"https://intersight.com"` | no |
| <a name="input_iks_cluster"></a> [iks\_cluster](#input\_iks\_cluster) | Intersight Kubernetes Service Cluster Profile Variable Map.<br>1. action\_cluster - Action to perform on the Kubernetes Cluster.  Options are {Delete\|Deploy\|Ready\|No-op\|Unassign}.<br>2. action\_control\_plane - Action to perform on the Kubernetes Control Plane Nodes.  Options are {Delete\|Deploy\|Ready\|No-op\|Unassign}.<br>3. action\_worker - Action to perform on the Kubernetes Worker Nodes.  Options are {Delete\|Deploy\|Ready\|No-op\|Unassign}.<br>4. control\_plane\_desired\_size - Desired number of control plane nodes in this node group, same as minsize initially and is updated by the auto-scaler.  Options are {1\|3}.<br>5. control\_plane\_k8s\_labels - List of key/value Attributes to Assign to the control plane node configuration.<br>6. control\_plane\_max\_size - Maximum number of control plane nodes desired in this node group.  Range is 1-128.<br>7. description - A description for the policy.<br>8. ip\_pool\_moid - Name of the IP Pool to assign to Cluster and Node Profiles.<br>9. k8s\_addon\_policy\_moid - Names of the Kubernetes Add-ons to add to the cluster.  Options are {ccp-monitor\|kubernetes-dashboard} or [].<br>10. k8s\_network\_cidr\_moid - Name of the Kubneretes Network CIDR Policy to assign to Cluster.<br>11. k8s\_nodeos\_config\_moid - Name of the Kubneretes Node OS Config Policy to assign to Cluster and Node Profiles.<br>12. k8s\_registry\_moid - Name of the Kubernetes Trusted Registry Policy to assign to Cluster and Node Profiles<br>.13. k8s\_runtime\_moid - Name of the Kubernetes Runtime Policy to assign to Cluster and Node Profiles<br>.14. k8s\_version\_moid - Name of the Kubernetes Version Policy to assign to the Node Profiles.<br>15. k8s\_vm\_infra\_moid - Name of the Kubernetes Virtual Machine Infra Config Policy to assign to the Node Profiles.<br>16. k8s\_vm\_instance\_type\_ctrl\_plane - Name of the Kubernetes Virtual Machine Instance Type Policy to assign to control plane nodes.<br>17. k8s\_vm\_instance\_type\_worker - Name of the Kubernetes Virtual Machine Instance Type Policy to assign to worker nodes.<br>18. load\_balancers - Number of load balancer addresses to deploy. Range is 1-999.<br>19. ssh\_key - The SSH Key Name should be ssh\_key\_{1\|2\|3\|4\|5}.  This will point to the ssh\_key variable that will be used.<br>20. ssh\_user - SSH Username for node login.<br>21. tags - tags - List of key/value Attributes to Assign to the Profile.<br>22. wait\_for\_complete - This model object can trigger workflows. Use this option to wait for all running workflows to reach a complete state.<br>23. worker\_desired\_size - Desired number of nodes in this worker node group, same as minsize initially and is updated by the auto-scaler.  Range is 1-128.<br>24. worker\_k8s\_labels - List of key/value Attributes to Assign to the worker node configuration.<br>25. worker\_max\_size - Maximum number of worker nodes desired in this node group.  Range is 1-128. | <pre>map(object(<br>    {<br>      action_cluster                  = optional(string)<br>      action_control_plane            = optional(string)<br>      action_worker                   = optional(string)<br>      control_plane_desired_size      = optional(number)<br>      control_plane_k8s_labels        = optional(list(map(string)))<br>      control_plane_max_size          = optional(number)<br>      description                     = optional(string)<br>      ip_pool_moid                    = string<br>      k8s_addon_policy_moid           = optional(set(string))<br>      k8s_network_cidr_moid           = string<br>      k8s_nodeos_config_moid          = string<br>      k8s_registry_moid               = optional(string)<br>      k8s_runtime_moid                = optional(string)<br>      k8s_version_moid                = string<br>      k8s_vm_infra_moid               = string<br>      k8s_vm_instance_type_ctrl_plane = string<br>      k8s_vm_instance_type_worker     = string<br>      load_balancers                  = optional(number)<br>      ssh_key                         = string<br>      ssh_user                        = string<br>      tags                            = optional(list(map(string)))<br>      wait_for_complete               = optional(bool)<br>      worker_desired_size             = optional(number)<br>      worker_k8s_labels               = optional(list(map(string)))<br>      worker_max_size                 = optional(number)<br>    }<br>  ))</pre> | <pre>{<br>  "default": {<br>    "action_cluster": "Deploy",<br>    "action_control_plane": "No-op",<br>    "action_worker": "No-op",<br>    "control_plane_desired_size": 1,<br>    "control_plane_k8s_labels": [],<br>    "control_plane_max_size": 3,<br>    "description": "",<br>    "ip_pool_moid": "**REQUIRED**",<br>    "k8s_addon_policy_moid": [],<br>    "k8s_network_cidr_moid": "**REQUIRED**",<br>    "k8s_nodeos_config_moid": "**REQUIRED**",<br>    "k8s_registry_moid": "",<br>    "k8s_runtime_moid": "",<br>    "k8s_version_moid": "**REQUIRED**",<br>    "k8s_vm_infra_moid": "**REQUIRED**",<br>    "k8s_vm_instance_type_ctrl_plane": "**REQUIRED**",<br>    "k8s_vm_instance_type_worker": "**REQUIRED**",<br>    "load_balancers": 3,<br>    "ssh_key": "ssh_key_1",<br>    "ssh_user": "iksadmin",<br>    "tags": [],<br>    "wait_for_complete": false,<br>    "worker_desired_size": 0,<br>    "worker_k8s_labels": [],<br>    "worker_max_size": 4<br>  }<br>}</pre> | no |
| <a name="input_ip_pools"></a> [ip\_pools](#input\_ip\_pools) | Intersight IP Pool Variable Map.<br>1. description - A description for the policy.<br>2. from - host address of the pool starting address.<br>3. gateway - ip/prefix of the gateway.<br>4. name - Name of the IP Pool.<br>5. size - Number of host addresses to assign to the pool.<br>6. tags - List of key/value Attributes to Assign to the Policy. | <pre>map(object(<br>    {<br>      description = optional(string)<br>      from        = optional(number)<br>      gateway     = optional(string)<br>      name        = optional(string)<br>      size        = optional(number)<br>      tags        = optional(list(map(string)))<br>    }<br>  ))</pre> | <pre>{<br>  "default": {<br>    "description": "",<br>    "from": 20,<br>    "gateway": "198.18.0.1/24",<br>    "name": "{organization}_ip_pool",<br>    "size": 30,<br>    "tags": []<br>  }<br>}</pre> | no |
| <a name="input_k8s_addon_policies"></a> [k8s\_addon\_policies](#input\_k8s\_addon\_policies) | Intersight Kubernetes Service Add-ons Variable Map.  Add-ons Options are {ccp-monitor\|kubernetes-dashboard} currently.<br>1. description - A description for the policy.<br>2. install\_strategy - Addon install strategy to determine whether an addon is installed if not present.<br> * None - Unspecified install strategy.<br> * NoAction - No install action performed.<br> * InstallOnly - Only install in green field. No action in case of failure or removal.<br> * Always - Attempt install if chart is not already installed.<br>3. name - Name of the concrete policy.<br>4. release\_name - Name for the helm release.<br>5. release\_namespace - Namespace for the helm release.<br>6. tags - List of key/value Attributes to Assign to the Policy.<br>7. upgrade\_strategy - Addon upgrade strategy to determine whether an addon configuration is overwritten on upgrade.<br> * None - Unspecified upgrade strategy.<br> * NoAction - This choice enables No upgrades to be performed.<br> * UpgradeOnly - Attempt upgrade if chart or overrides options change, no action on upgrade failure.<br> * ReinstallOnFailure - Attempt upgrade first. Remove and install on upgrade failure.<br> * AlwaysReinstall - Always remove older release and reinstall. | <pre>map(object(<br>    {<br>      description       = optional(string)<br>      install_strategy  = optional(string)<br>      name              = optional(string)<br>      release_name      = optional(string)<br>      release_namespace = optional(string)<br>      tags              = optional(list(map(string)))<br>      upgrade_strategy  = optional(string)<br>    }<br>  ))</pre> | <pre>{<br>  "default": {<br>    "description": "",<br>    "install_strategy": "Always",<br>    "name": "{organization}_{each.key}",<br>    "release_name": "",<br>    "release_namespace": "",<br>    "tags": [],<br>    "upgrade_strategy": "UpgradeOnly"<br>  }<br>}</pre> | no |
| <a name="input_k8s_network_cidr"></a> [k8s\_network\_cidr](#input\_k8s\_network\_cidr) | Intersight Kubernetes Network CIDR Policy Variable Map.<br>1. cidr\_pod - CIDR block to allocate pod network IP addresses from.<br>2. cidr\_service - Pod CIDR Block to be used to assign Pod IP Addresses.<br>3. cni\_type - Supported CNI type. Currently we only support Calico.<br>* Calico - Calico CNI plugin as described in https://github.com/projectcalico/cni-plugin.<br>* Aci - Cisco ACI Container Network Interface plugin.<br>4. description - A description for the policy.<br>5. name - Name of the concrete policy.<br>6. tags - tags - List of key/value Attributes to Assign to the Policy. | <pre>map(object(<br>    {<br>      cidr_pod     = optional(string)<br>      cidr_service = optional(string)<br>      cni_type     = optional(string)<br>      description  = optional(string)<br>      name         = optional(string)<br>      tags         = optional(list(map(string)))<br>    }<br>  ))</pre> | <pre>{<br>  "default": {<br>    "cidr_pod": "100.64.0.0/16",<br>    "cidr_service": "100.65.0.0/16",<br>    "cni_type": "Calico",<br>    "description": "",<br>    "name": "{organization}_network_cidr",<br>    "tags": []<br>  }<br>}</pre> | no |
| <a name="input_k8s_nodeos_config"></a> [k8s\_nodeos\_config](#input\_k8s\_nodeos\_config) | Intersight Kubernetes Node OS Configuration Policy Variable Map.<br>1. description - A description for the policy.<br>2. dns\_servers\_v4 - DNS Servers for the Kubernetes Node OS Configuration Policy.<br>3. domain\_name - Domain Name for the Kubernetes Node OS Configuration Policy.<br>4. ntp\_servers - NTP Servers for the Kubernetes Node OS Configuration Policy.<br>5. name - Name of the concrete policy.<br>6. tags - tags - List of key/value Attributes to Assign to the Policy.<br>7. timezone - The timezone of the node's system clock.  For a List of supported timezones see the following URL.<br> https://github.com/terraform-cisco-modules/terraform-intersight-imm/blob/master/modules/policies_ntp/README.md. | <pre>map(object(<br>    {<br>      description    = optional(string)<br>      dns_servers_v4 = optional(list(string))<br>      domain_name    = optional(string)<br>      ntp_servers    = optional(list(string))<br>      name           = optional(string)<br>      tags           = optional(list(map(string)))<br>      timezone       = optional(string)<br>    }<br>  ))</pre> | <pre>{<br>  "default": {<br>    "description": "",<br>    "dns_servers_v4": [<br>      "208.67.220.220",<br>      "208.67.222.222"<br>    ],<br>    "domain_name": "example.com",<br>    "name": "{organization}_nodeos_config",<br>    "ntp_servers": [],<br>    "tags": [],<br>    "timezone": "Etc/GMT"<br>  }<br>}</pre> | no |
| <a name="input_k8s_runtime_create"></a> [k8s\_runtime\_create](#input\_k8s\_runtime\_create) | Flag to specify if the Kubernetes Runtime Policy should be created or not. | `bool` | `false` | no |
| <a name="input_k8s_runtime_http_password"></a> [k8s\_runtime\_http\_password](#input\_k8s\_runtime\_http\_password) | Password for the HTTP Proxy Server, If required. | `string` | `""` | no |
| <a name="input_k8s_runtime_https_password"></a> [k8s\_runtime\_https\_password](#input\_k8s\_runtime\_https\_password) | Password for the HTTPS Proxy Server, If required. | `string` | `""` | no |
| <a name="input_k8s_runtime_policies"></a> [k8s\_runtime\_policies](#input\_k8s\_runtime\_policies) | Intersight Kubernetes Runtime Policy Variable Map.<br>1. description - A description for the policy.<br>2. docker\_bridge\_cidr - The CIDR for docker bridge network. This address space must not collide with other CIDRs on your networks, including the cluster's service CIDR, pod CIDR and IP Pools.<br>3. docker\_no\_proxy - Docker no proxy list, when using internet proxy.<br>4. http\_hostname - Hostname of the HTTP Proxy Server.<br>5. http\_port - HTTP Proxy Port.  Range is 1-65535.<br>6. http\_protocol - HTTP Proxy Protocol. Options are {http\|https}.<br>7. http\_username - Username for the HTTP Proxy Server.<br>8. https\_hostname - Hostname of the HTTPS Proxy Server.<br>9. https\_port - HTTPS Proxy Port.  Range is 1-65535<br>10. https\_protocol - HTTPS Proxy Protocol. Options are {http\|https}.<br>11. https\_username - Username for the HTTPS Proxy Server.<br>12. name - Name of the concrete policy.<br>13. tags - List of key/value Attributes to Assign to the Policy. | <pre>map(object(<br>    {<br>      description        = optional(string)<br>      docker_bridge_cidr = optional(string)<br>      docker_no_proxy    = optional(list(string))<br>      http_hostname      = optional(string)<br>      http_port          = optional(number)<br>      http_protocol      = optional(string)<br>      http_username      = optional(string)<br>      https_hostname     = optional(string)<br>      https_port         = optional(number)<br>      https_protocol     = optional(string)<br>      https_username     = optional(string)<br>      name               = optional(string)<br>      tags               = optional(list(map(string)))<br>    }<br>  ))</pre> | <pre>{<br>  "default": {<br>    "description": "",<br>    "docker_bridge_cidr": "",<br>    "docker_no_proxy": [],<br>    "http_hostname": "",<br>    "http_port": 8080,<br>    "http_protocol": "http",<br>    "http_username": "",<br>    "https_hostname": "",<br>    "https_port": 8443,<br>    "https_protocol": "https",<br>    "https_username": "",<br>    "name": "{organization}_runtime",<br>    "tags": []<br>  }<br>}</pre> | no |
| <a name="input_k8s_trusted_create"></a> [k8s\_trusted\_create](#input\_k8s\_trusted\_create) | Flag to specify if the Kubernetes Runtime Policy should be created or not. | `bool` | `false` | no |
| <a name="input_k8s_trusted_registries"></a> [k8s\_trusted\_registries](#input\_k8s\_trusted\_registries) | Intersight Kubernetes Trusted Registry Policy Variable Map.<br>1. description - A description for the policy.<br>2. name - Name of the concrete policy.<br>3. root\_ca - List of root CA Signed Registries.<br>4. tags - List of key/value Attributes to Assign to the Policy.<br>5. unsigned - List of unsigned registries to be supported. | <pre>map(object(<br>    {<br>      description = optional(string)<br>      name        = optional(string)<br>      root_ca     = optional(list(string))<br>      tags        = optional(list(map(string)))<br>      unsigned    = optional(list(string))<br>    }<br>  ))</pre> | <pre>{<br>  "default": {<br>    "description": "",<br>    "name": "{organization}_registry",<br>    "root_ca": [],<br>    "tags": [],<br>    "unsigned": []<br>  }<br>}</pre> | no |
| <a name="input_k8s_version_policies"></a> [k8s\_version\_policies](#input\_k8s\_version\_policies) | Intersight Kubernetes Version Policy Variable Map.<br>1. description - A description for the policy.<br>2. name - Name of the concrete policy.<br>3. tags - List of key/value Attributes to Assign to the Policy.<br>4. version - Desired Kubernetes version.  Options are {1.19.5} | <pre>map(object(<br>    {<br>      description = optional(string)<br>      name        = optional(string)<br>      tags        = optional(list(map(string)))<br>      version     = optional(string)<br>    }<br>  ))</pre> | <pre>{<br>  "default": {<br>    "description": "",<br>    "name": "{organization}_v{each.value.version}",<br>    "tags": [],<br>    "version": "1.19.5"<br>  }<br>}</pre> | no |
| <a name="input_k8s_vm_infra_config"></a> [k8s\_vm\_infra\_config](#input\_k8s\_vm\_infra\_config) | Intersight Kubernetes Virtual Machine Infra Config Policy Variable Map.<br><br>1. description - A description for the policy.<br>2. name - Name of the concrete policy.<br>3. tags - List of key/value Attributes to Assign to the Policy.<br>4. vsphere\_cluster - vSphere Cluster to assign the K8S Cluster Deployment.<br>5. vsphere\_datastore - vSphere Datastore to assign the K8S Cluster Deployment.r<br>6. vsphere\_portgroup - vSphere Port Group to assign the K8S Cluster Deployment.r<br>7. vsphere\_resource\_pool - vSphere Resource Pool to assign the K8S Cluster Deployment.r<br>8. vsphere\_target - Name of the vSphere Target discovered in Intersight, to provision the cluster on. | <pre>map(object(<br>    {<br>      description           = optional(string)<br>      name                  = optional(string)<br>      tags                  = optional(list(map(string)))<br>      vsphere_cluster       = string<br>      vsphere_datastore     = string<br>      vsphere_portgroup     = list(string)<br>      vsphere_resource_pool = optional(string)<br>      vsphere_target        = string<br>    }<br>  ))</pre> | <pre>{<br>  "default": {<br>    "description": "",<br>    "name": "{organization}_vm_infra",<br>    "tags": [],<br>    "vsphere_cluster": "default",<br>    "vsphere_datastore": "datastore1",<br>    "vsphere_portgroup": [<br>      "VM Network"<br>    ],<br>    "vsphere_resource_pool": "",<br>    "vsphere_target": ""<br>  }<br>}</pre> | no |
| <a name="input_k8s_vm_infra_password"></a> [k8s\_vm\_infra\_password](#input\_k8s\_vm\_infra\_password) | vSphere Password.  Note: this is the password of the Credentials used to register the vSphere Target. | `string` | n/a | yes |
| <a name="input_k8s_vm_instance_type"></a> [k8s\_vm\_instance\_type](#input\_k8s\_vm\_instance\_type) | Intersight Kubernetes Node OS Configuration Policy Variable Map.  Name of the policy will be {organization}\_{each.key}.<br>1. cpu - Number of CPUs allocated to virtual machine.  Range is 1-40.<br>2. description - A description for the policy.<br>3. disk - Ephemeral disk capacity to be provided with units example - 10 for 10 Gigabytes.<br>4. memory - Virtual machine memory defined in mebibytes (MiB).  Range is 1-4177920.<br>5. tags - List of key/value Attributes to Assign to the Policy. | <pre>map(object(<br>    {<br>      cpu         = optional(number)<br>      description = optional(string)<br>      disk        = optional(number)<br>      memory      = optional(number)<br>      tags        = optional(list(map(string)))<br>    }<br>  ))</pre> | <pre>{<br>  "default": {<br>    "cpu": 4,<br>    "description": "",<br>    "disk": 40,<br>    "memory": 16384,<br>    "tags": []<br>  }<br>}</pre> | no |
| <a name="input_organization"></a> [organization](#input\_organization) | Intersight Organization Name. | `string` | `"default"` | no |
| <a name="input_secretkey"></a> [secretkey](#input\_secretkey) | Intersight Secret Key. | `string` | n/a | yes |
| <a name="input_ssh_key_1"></a> [ssh\_key\_1](#input\_ssh\_key\_1) | Intersight Kubernetes Service Cluster SSH Public Key 1. | `string` | `""` | no |
| <a name="input_ssh_key_2"></a> [ssh\_key\_2](#input\_ssh\_key\_2) | Intersight Kubernetes Service Cluster SSH Public Key 2.  These are place holders for Tenants that use different keys for different clusters. | `string` | `""` | no |
| <a name="input_ssh_key_3"></a> [ssh\_key\_3](#input\_ssh\_key\_3) | Intersight Kubernetes Service Cluster SSH Public Key 3.  These are place holders for Tenants that use different keys for different clusters. | `string` | `""` | no |
| <a name="input_ssh_key_4"></a> [ssh\_key\_4](#input\_ssh\_key\_4) | Intersight Kubernetes Service Cluster SSH Public Key 4.  These are place holders for Tenants that use different keys for different clusters. | `string` | `""` | no |
| <a name="input_ssh_key_5"></a> [ssh\_key\_5](#input\_ssh\_key\_5) | Intersight Kubernetes Service Cluster SSH Public Key 5.  These are place holders for Tenants that use different keys for different clusters. | `string` | `""` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to be Associated with Objects Created in Intersight. | `list(map(string))` | `[]` | no |
| <a name="input_terraform_cloud_token"></a> [terraform\_cloud\_token](#input\_terraform\_cloud\_token) | Token to Authenticate to the Terraform Cloud. | `string` | n/a | yes |
| <a name="input_terraform_version"></a> [terraform\_version](#input\_terraform\_version) | Terraform Target Version. | `string` | `"1.0.0"` | no |
| <a name="input_tfc_oath_token"></a> [tfc\_oath\_token](#input\_tfc\_oath\_token) | Terraform Cloud OAuth Token for VCS\_Repo Integration. | `string` | n/a | yes |
| <a name="input_tfc_organization"></a> [tfc\_organization](#input\_tfc\_organization) | Terraform Cloud Organization Name. | `string` | n/a | yes |
| <a name="input_vcs_repo"></a> [vcs\_repo](#input\_vcs\_repo) | Version Control System Repository. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_app_hello_workspaces"></a> [app\_hello\_workspaces](#output\_app\_hello\_workspaces) | Terraform Cloud App Hello Workspace ID(s). |
| <a name="output_iks_workspaces"></a> [iks\_workspaces](#output\_iks\_workspaces) | Terraform Cloud IKS Workspace ID(s). |
| <a name="output_iwo_workspaces"></a> [iwo\_workspaces](#output\_iwo\_workspaces) | Terraform Cloud IWO Workspace ID(s). |
| <a name="output_kube_workspaces"></a> [kube\_workspaces](#output\_kube\_workspaces) | Terraform Cloud Kube Workspace ID(s). |
| <a name="output_org_workspace"></a> [org\_workspace](#output\_org\_workspace) | Terraform Cloud Intersight Organization Workspace ID. |
| <a name="output_tfc_agent_pool"></a> [tfc\_agent\_pool](#output\_tfc\_agent\_pool) | Terraform Cloud Agent Pool ID. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

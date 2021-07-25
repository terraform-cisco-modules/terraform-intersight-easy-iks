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

The Following examples are for a Linux based Operating System.  Note that the TF_VAR_ prefix is used as a notification to the terraform engine that the environment variable will be consumed by terraform.

* Terraform Cloud Variables

```bash
export TF_VAR_terraform_cloud_token="your_cloud_token"
export TF_VAR_tfc_oath_token="your_oath_token"
export TF_VAR_tfc_email="your_email"
export TF_VAR_agent_pool="your_agent_pool_name"
export TF_VAR_vcs_repo="your_vcs_repo"
```

* Intersight Variables

```bash
export TF_VAR_apikey="your_api_key"
export TF_VAR_secretkey="your_secret_key"
```

* Global Variables
  Refer to explanation below on the purpose of the network_prefix variable

```bash
export TF_VAR_network_prefix="10.200.0"
```

* vSphere Variables

```bash
export TF_VAR_vsphere_password="your_vshpere_password"
```

* Kubernetes Cluster Variables

```bash
export TF_VAR_ssh_key="your_ssh_key"
```

* Kubernetes Cluster Add-ons Variables

If you want to add both Add-ons that are supported today {ccp-monitor|kubernetes-dashboard} use the following list:

```bash
export TF_VAR_addons_list="[\"ccp-monitor\", \"kubernetes-dashboard\"]"
```

You can also just include one or the other add-ons.

## Optional Variables

Below are additional variables that have been assigned default values already.  Confirm anything that needs to change for your environment.  The default values are shown below.

* Terraform Cloud Default Variables

```bash
export TF_VAR_tfc_organization="CiscoDevNet"
export TF_VAR_terraform_version="1.0.0"
```

* Intersight Default Variables

```bash
export TF_VAR_organization="default"
```

* Kubernetes Cluster and Policies Default Variables

    To help simplify the number of variables that are required, the following manipulation rules have been added to the global_vars.

    network_prefix function ip_pool_gateway, ip_pool_from, and vsphere_target:

    The default value is shown below.  For Example with vsphere_target showing the IPv4 last octet of 210.

    This is combined with the network_prefix to become 10.200.0.210.  

    This combine function works with the following variables:

    ip_pool_gateway

    ip_pool_from

    vsphere_target

    Secondary Note: dns_servers will also be assigned to ntp_servers if you don't assign anything to ntp_servers.

```bash
export TF_VAR_domain_name="demo.intra"
export TF_VAR_dns_servers="[\"10.200.0.100\"]"
export TF_VAR_ntp_servers="[]"
export TF_VAR_ip_pool_gateway="254"
export TF_VAR_ip_pool_from="20"
export TF_VAR_k8s_pod_cidr="100.65.0.0/16"
export TF_VAR_k8s_service_cidr="100.64.0.0/16"
export TF_VAR_k8s_k8s_version="1.19.5"
export TF_VAR_root_ca_registries="[]"
export TF_VAR_unsigned_registries="[]"
```

* Kubernetes Runtime Optional Variables

```bash
export TF_VAR_docker_no_proxy="[]"
export TF_VAR_proxy_http_hostname=""
export TF_VAR_proxy_http_password=""
export TF_VAR_proxy_http_port="8080"
export TF_VAR_proxy_http_protocol="http"
export TF_VAR_proxy_http_username=""
export TF_VAR_proxy_https_hostname=""
export TF_VAR_proxy_https_password=""
export TF_VAR_proxy_https_port="8443"
export TF_VAR_proxy_https_username=""
```

Note: The proxy_http_hostname will be cloned to the proxy_https_hostname if left blank, when configuring runtime policies.

Note: The proxy_http_username will be cloned to the proxy_https_username if left blank, when configuring runtime policies.

* Kubernetes Cluster Optional Variables

```bash
export TF_VAR_tags="[]"
export TF_VAR_action="Deploy"
export TF_VAR_cluster_name="iks"
export TF_VAR_load_balancers="3"
export TF_VAR_ssh_user="iksadmin"
export TF_VAR_master_instance_type="small"
export TF_VAR_master_desired_size="1"
export TF_VAR_master_max_size="1"
export TF_VAR_worker_instance_type="small"
export TF_VAR_worker_desired_size="0"
export TF_VAR_worker_max_size="1"
```

* vSphere Optional Variables

  Note: The same rules above apply to the vsphere_target address.  But you can use dns or IPv4 values when modifying.

```bash
export TF_VAR_vsphere_target="210"
export TF_VAR_vsphere_cluster="hx-demo"
export TF_VAR_vsphere_datastore="hx-demo-ds1"
export TF_VAR_vsphere_portgroup="[\"Management\"]"
export TF_VAR_vsphere_resource_pool=""
```

For the Cluster tags; below is an example key/value format.

```bash
export TF_VAR_tags="[ { key = \"Terraform\", value = \"Module\" }, { key = \"Owner\", value = \"CiscoDevNet\" } ]"
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
| <a name="module_tfc_agent_pool"></a> [tfc\_agent\_pool](#module\_tfc\_agent\_pool) | terraform-cisco-modules/modules/tfe//modules/tfc_agent_pool | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_agent_pool"></a> [agent\_pool](#input\_agent\_pool) | Terraform Cloud Agent Pool. | `string` | n/a | yes |
| <a name="input_apikey"></a> [apikey](#input\_apikey) | Intersight API Key. | `string` | n/a | yes |
| <a name="input_dns_servers_v4"></a> [dns\_servers\_v4](#input\_dns\_servers\_v4) | DNS Servers for Kubernetes Sysconfig Policy. | `list(string)` | <pre>[<br>  "198.18.0.100",<br>  "198.18.0.101"<br>]</pre> | no |
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | Domain Name for Kubernetes Sysconfig Policy. | `string` | `"example.com"` | no |
| <a name="input_endpoint"></a> [endpoint](#input\_endpoint) | Intersight URL. | `string` | `"https://intersight.com"` | no |
| <a name="input_iks_cluster"></a> [iks\_cluster](#input\_iks\_cluster) | Action to perform on the Intersight Kubernetes Cluster.  Options are {Delete\|Deploy\|Ready\|No-op\|Unassign}. | <pre>map(object(<br>    {<br>      action_cluster             = optional(string)<br>      action_control_plane       = optional(string)<br>      action_worker              = optional(string)<br>      action                     = optional(string)<br>      addons                     = optional(set(string))<br>      control_plane_desired_size = optional(number)<br>      control_plane_intance_moid = string<br>      control_plane_max_size     = optional(number)<br>      ip_pool_moid               = string<br>      k8s_vm_infra_moid          = string<br>      load_balancers             = optional(number)<br>      ssh_key                    = string<br>      ssh_user                   = string<br>      registry_moid              = optional(string)<br>      runtime_moid               = optional(list(map(string)))<br>      tags                       = optional(list(map(string)))<br>      version_moid               = string<br>      vm_network_moid            = string<br>      wait_for_complete          = optional(bool)<br>      worker_desired_size        = optional(number)<br>      worker_intance_moid        = string<br>      worker_max_size            = optional(number)<br>    }<br>  ))</pre> | <pre>{<br>  "default": {<br>    "action_cluster": "Deploy",<br>    "action_control_plane": "No-op",<br>    "action_worker": "No-op",<br>    "addons": [],<br>    "control_plane_desired_size": 1,<br>    "control_plane_intance_moid": "**REQUIRED**",<br>    "control_plane_max_size": 3,<br>    "ip_pool_moid": "**REQUIRED**",<br>    "k8s_vm_infra_moid": "**REQUIRED**",<br>    "load_balancers": 3,<br>    "registry_moid": "",<br>    "runtime_moid": [],<br>    "ssh_key": "ssh_key_1",<br>    "ssh_user": "iksadmin",<br>    "tags": [],<br>    "version_moid": "**REQUIRED**",<br>    "vm_network_moid": "**REQUIRED**",<br>    "wait_for_complete": false,<br>    "worker_desired_size": 0,<br>    "worker_intance_moid": "**REQUIRED**",<br>    "worker_max_size": 4<br>  }<br>}</pre> | no |
| <a name="input_ip_pools"></a> [ip\_pools](#input\_ip\_pools) | * from - host address of the pool starting address.  Default is 20<br>* gateway - ip/prefix of the gateway.  Default is 198.18.0.1/24<br>* name - Name of the IP Pool.  Default is {tenant}\_{cluster\_name}\_ip\_pool.<br>* size - Number of host addresses to assign to the pool.  Default is 30. | <pre>map(object(<br>    {<br>      from    = optional(number)<br>      gateway = optional(string)<br>      name    = optional(string)<br>      size    = optional(number)<br>      tags    = optional(list(map(string)))<br>    }<br>  ))</pre> | <pre>{<br>  "default": {<br>    "from": 20,<br>    "gateway": "198.18.0.1/24",<br>    "name": "{tenant_name}_ip_pool",<br>    "size": 30,<br>    "tags": []<br>  }<br>}</pre> | no |
| <a name="input_k8s_addons"></a> [k8s\_addons](#input\_k8s\_addons) | Map of Add-ons for Intersight Kubernetes Service.  Add-ons Options are {ccp-monitor\|kubernetes-dashboard}. | <pre>map(object(<br>    {<br>      install_strategy = optional(string)<br>      name             = optional(string)<br>      release_name     = optional(string)<br>      tags             = optional(list(map(string)))<br>      upgrade_strategy = optional(string)<br>    }<br>  ))</pre> | <pre>{<br>  "default": {<br>    "install_strategy": "Always",<br>    "name": "{tenant_name}_{addon_key}",<br>    "release_name": "",<br>    "tags": [],<br>    "upgrade_strategy": "UpgradeOnly"<br>  }<br>}</pre> | no |
| <a name="input_k8s_runtime"></a> [k8s\_runtime](#input\_k8s\_runtime) | n/a | <pre>map(object(<br>    {<br>      docker_bridge_cidr = optional(string)<br>      docker_no_proxy    = optional(list(string))<br>      http_hostname      = optional(string)<br>      http_port          = optional(number)<br>      http_protocol      = optional(string)<br>      http_username      = optional(string)<br>      https_hostname     = optional(string)<br>      https_port         = optional(number)<br>      https_protocol     = optional(string)<br>      https_username     = optional(string)<br>      name               = optional(string)<br>      tags               = optional(list(map(string)))<br>    }<br>  ))</pre> | <pre>{<br>  "default": {<br>    "docker_bridge_cidr": "",<br>    "docker_no_proxy": [],<br>    "http_hostname": "",<br>    "http_port": 8080,<br>    "http_protocol": "http",<br>    "http_username": "",<br>    "https_hostname": "",<br>    "https_port": 8443,<br>    "https_protocol": "https",<br>    "https_username": "",<br>    "name": "",<br>    "tags": []<br>  }<br>}</pre> | no |
| <a name="input_k8s_runtime_create"></a> [k8s\_runtime\_create](#input\_k8s\_runtime\_create) | Flag to specify if the Kubernetes Runtime Policy should be created or not. | `bool` | `false` | no |
| <a name="input_k8s_runtime_http_password"></a> [k8s\_runtime\_http\_password](#input\_k8s\_runtime\_http\_password) | Password for the HTTP Proxy Server, If required. | `string` | `""` | no |
| <a name="input_k8s_runtime_https_password"></a> [k8s\_runtime\_https\_password](#input\_k8s\_runtime\_https\_password) | Password for the HTTPS Proxy Server, If required. | `string` | `""` | no |
| <a name="input_k8s_trusted_create"></a> [k8s\_trusted\_create](#input\_k8s\_trusted\_create) | Flag to specify if the Kubernetes Runtime Policy should be created or not. | `bool` | `false` | no |
| <a name="input_k8s_trusted_registry"></a> [k8s\_trusted\_registry](#input\_k8s\_trusted\_registry) | n/a | <pre>map(object(<br>    {<br>      name     = optional(string)<br>      root_ca  = optional(list(string))<br>      tags     = optional(list(map(string)))<br>      unsigned = optional(list(string))<br>    }<br>  ))</pre> | <pre>{<br>  "default": {<br>    "name": "",<br>    "root_ca": [],<br>    "tags": [],<br>    "unsigned": []<br>  }<br>}</pre> | no |
| <a name="input_k8s_version"></a> [k8s\_version](#input\_k8s\_version) | Kubernetes Version to Deploy. | <pre>map(object(<br>    {<br>      name    = optional(string)<br>      tags    = optional(list(map(string)))<br>      version = optional(string)<br>    }<br>  ))</pre> | <pre>{<br>  "default": {<br>    "name": "",<br>    "tags": [],<br>    "version": "1.19.5"<br>  }<br>}</pre> | no |
| <a name="input_k8s_vm_infra"></a> [k8s\_vm\_infra](#input\_k8s\_vm\_infra) | Kubernetes Virtual Machine Infrastructure Configuration Policy.  Default name is {tenant\_name}\_vm\_infra. | <pre>map(object(<br>    {<br>      name                  = optional(string)<br>      tags                  = optional(list(map(string)))<br>      vsphere_cluster       = string<br>      vsphere_datastore     = string<br>      vsphere_portgroup     = list(string)<br>      vsphere_resource_pool = optional(string)<br>      vsphere_target        = string<br>    }<br>  ))</pre> | <pre>{<br>  "default": {<br>    "name": "",<br>    "tags": [],<br>    "vsphere_cluster": "default",<br>    "vsphere_datastore": "datastore1",<br>    "vsphere_portgroup": [<br>      "VM Network"<br>    ],<br>    "vsphere_resource_pool": "",<br>    "vsphere_target": ""<br>  }<br>}</pre> | no |
| <a name="input_k8s_vm_infra_password"></a> [k8s\_vm\_infra\_password](#input\_k8s\_vm\_infra\_password) | vSphere Password.  Note: this is the password of the Credentials used to register the vSphere Target. | `string` | n/a | yes |
| <a name="input_k8s_vm_instance"></a> [k8s\_vm\_instance](#input\_k8s\_vm\_instance) | Kubernetes Virtual Machine Instance Policy Variables.  Default name is {tenant\_name}\_vm\_network. | <pre>map(object(<br>    {<br>      cpu    = optional(number)<br>      disk   = optional(number)<br>      memory = optional(number)<br>      tags   = optional(list(map(string)))<br>    }<br>  ))</pre> | <pre>{<br>  "default": {<br>    "cpu": 4,<br>    "disk": 40,<br>    "memory": 16384,<br>    "tags": []<br>  }<br>}</pre> | no |
| <a name="input_k8s_vm_network"></a> [k8s\_vm\_network](#input\_k8s\_vm\_network) | Kubernetes Virtual Machine Network Configuration Policy.  Default name is {tenant\_name}\_vm\_network. | <pre>map(object(<br>    {<br>      cidr_pod     = optional(string)<br>      cidr_service = optional(string)<br>      cni          = optional(string)<br>      name         = optional(string)<br>      tags         = optional(list(map(string)))<br>    }<br>  ))</pre> | <pre>{<br>  "default": {<br>    "cidr_pod": "100.64.0.0/16",<br>    "cidr_service": "100.65.0.0/16",<br>    "cni": "Calico",<br>    "name": "",<br>    "tags": []<br>  }<br>}</pre> | no |
| <a name="input_ntp_servers"></a> [ntp\_servers](#input\_ntp\_servers) | NTP Servers for Kubernetes Sysconfig Policy. | `list(string)` | `[]` | no |
| <a name="input_organization"></a> [organization](#input\_organization) | Intersight Organization Name. | `string` | `"default"` | no |
| <a name="input_secretkey"></a> [secretkey](#input\_secretkey) | Intersight Secret Key. | `string` | n/a | yes |
| <a name="input_ssh_key_1"></a> [ssh\_key\_1](#input\_ssh\_key\_1) | Intersight Kubernetes Service Cluster SSH Public Key 1. | `string` | `""` | no |
| <a name="input_ssh_key_2"></a> [ssh\_key\_2](#input\_ssh\_key\_2) | Intersight Kubernetes Service Cluster SSH Public Key 2.  These are place holders for Tenants that use different keys for different clusters. | `string` | `""` | no |
| <a name="input_ssh_key_3"></a> [ssh\_key\_3](#input\_ssh\_key\_3) | Intersight Kubernetes Service Cluster SSH Public Key 3.  These are place holders for Tenants that use different keys for different clusters. | `string` | `""` | no |
| <a name="input_ssh_key_4"></a> [ssh\_key\_4](#input\_ssh\_key\_4) | Intersight Kubernetes Service Cluster SSH Public Key 4.  These are place holders for Tenants that use different keys for different clusters. | `string` | `""` | no |
| <a name="input_ssh_key_5"></a> [ssh\_key\_5](#input\_ssh\_key\_5) | Intersight Kubernetes Service Cluster SSH Public Key 5.  These are place holders for Tenants that use different keys for different clusters. | `string` | `""` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to be Associated with Objects Created in Intersight. | `list(map(string))` | `[]` | no |
| <a name="input_tenant_name"></a> [tenant\_name](#input\_tenant\_name) | Tenant Name for Workspace Creation in Terraform Cloud and IKS Cluster Naming. | `string` | `"default"` | no |
| <a name="input_terraform_cloud_token"></a> [terraform\_cloud\_token](#input\_terraform\_cloud\_token) | Token to Authenticate to the Terraform Cloud. | `string` | n/a | yes |
| <a name="input_terraform_version"></a> [terraform\_version](#input\_terraform\_version) | Terraform Target Version. | `string` | `"1.0.0"` | no |
| <a name="input_tfc_oath_token"></a> [tfc\_oath\_token](#input\_tfc\_oath\_token) | Terraform Cloud OAuth Token for VCS\_Repo Integration. | `string` | n/a | yes |
| <a name="input_tfc_organization"></a> [tfc\_organization](#input\_tfc\_organization) | Terraform Cloud Organization Name. | `string` | n/a | yes |
| <a name="input_timezone"></a> [timezone](#input\_timezone) | Timezone for Deployment.  For a List of supported timezones see the following URL.<br> https://github.com/terraform-cisco-modules/terraform-intersight-imm/blob/master/modules/policies_ntp/README.md. | `string` | `"Etc/GMT"` | no |
| <a name="input_vcs_repo"></a> [vcs\_repo](#input\_vcs\_repo) | Version Control System Repository. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_app_hello_workspaces"></a> [app\_hello\_workspaces](#output\_app\_hello\_workspaces) | Terraform Cloud App Hello Workspace ID(s). |
| <a name="output_iks_workspaces"></a> [iks\_workspaces](#output\_iks\_workspaces) | Terraform Cloud IKS Workspace ID(s). |
| <a name="output_iwo_workspaces"></a> [iwo\_workspaces](#output\_iwo\_workspaces) | Terraform Cloud IWO Workspace ID(s). |
| <a name="output_kube_workspaces"></a> [kube\_workspaces](#output\_kube\_workspaces) | Terraform Cloud Kube Workspace ID(s). |
| <a name="output_tfc_agent_pool"></a> [tfc\_agent\_pool](#output\_tfc\_agent\_pool) | Terraform Cloud Agent Pool ID. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

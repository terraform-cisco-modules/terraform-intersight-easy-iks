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
export TF_VAR_secretkey=`{source_dir}/intersight_secretkey.txt`
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
| <a name="module_intersight_variables"></a> [intersight\_variables](#module\_intersight\_variables) | terraform-cisco-modules/modules/tfe//modules/tfc_variables | n/a |
| <a name="module_kubernetes_cluster_profiles_variables"></a> [kubernetes\_cluster\_profiles\_variables](#module\_kubernetes\_cluster\_profiles\_variables) | terraform-cisco-modules/modules/tfe//modules/tfc_variables | n/a |
| <a name="module_kubernetes_policies_variables"></a> [kubernetes\_policies\_variables](#module\_kubernetes\_policies\_variables) | terraform-cisco-modules/modules/tfe//modules/tfc_variables | n/a |
| <a name="module_tfc_agent_pool"></a> [tfc\_agent\_pool](#module\_tfc\_agent\_pool) | terraform-cisco-modules/modules/tfe//modules/tfc_agent_pool | n/a |
| <a name="module_workspaces"></a> [workspaces](#module\_workspaces) | terraform-cisco-modules/modules/tfe//modules/tfc_workspace | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_agent_pool"></a> [agent\_pool](#input\_agent\_pool) | Terraform Cloud Agent Pool. | `string` | n/a | yes |
| <a name="input_apikey"></a> [apikey](#input\_apikey) | Intersight API Key. | `string` | n/a | yes |
| <a name="input_secretkey"></a> [secretkey](#input\_secretkey) | Intersight Secret Key. | `string` | n/a | yes |
| <a name="input_ssh_public_key_1"></a> [ssh\_public\_key\_1](#input\_ssh\_public\_key\_1) | Intersight Kubernetes Service Cluster SSH Public Key 1. | `string` | `""` | no |
| <a name="input_ssh_public_key_2"></a> [ssh\_public\_key\_2](#input\_ssh\_public\_key\_2) | Intersight Kubernetes Service Cluster SSH Public Key 2.  These are place holders for Clusters that use different keys for different clusters. | `string` | `""` | no |
| <a name="input_ssh_public_key_3"></a> [ssh\_public\_key\_3](#input\_ssh\_public\_key\_3) | Intersight Kubernetes Service Cluster SSH Public Key 3.  These are place holders for Clusters that use different keys for different clusters. | `string` | `""` | no |
| <a name="input_ssh_public_key_4"></a> [ssh\_public\_key\_4](#input\_ssh\_public\_key\_4) | Intersight Kubernetes Service Cluster SSH Public Key 4.  These are place holders for Clusters that use different keys for different clusters. | `string` | `""` | no |
| <a name="input_ssh_public_key_5"></a> [ssh\_public\_key\_5](#input\_ssh\_public\_key\_5) | Intersight Kubernetes Service Cluster SSH Public Key 5.  These are place holders for Clusters that use different keys for different clusters. | `string` | `""` | no |
| <a name="input_terraform_cloud_token"></a> [terraform\_cloud\_token](#input\_terraform\_cloud\_token) | Token to Authenticate to the Terraform Cloud. | `string` | n/a | yes |
| <a name="input_terraform_version"></a> [terraform\_version](#input\_terraform\_version) | Terraform Target Version. | `string` | `"1.0.3"` | no |
| <a name="input_tfc_oauth_token"></a> [tfc\_oauth\_token](#input\_tfc\_oauth\_token) | Terraform Cloud OAuth Token for VCS\_Repo Integration. | `string` | n/a | yes |
| <a name="input_tfc_organization"></a> [tfc\_organization](#input\_tfc\_organization) | Terraform Cloud Organization Name. | `string` | n/a | yes |
| <a name="input_vcs_repo"></a> [vcs\_repo](#input\_vcs\_repo) | Version Control System Repository. | `string` | n/a | yes |
| <a name="input_vsphere_password"></a> [vsphere\_password](#input\_vsphere\_password) | vSphere Password.  Note: this is the password of the Credentials used to register the vSphere Target. | `string` | n/a | yes |
| <a name="input_workspaces"></a> [workspaces](#input\_workspaces) | Map of Workspaces to create in Terraform Cloud.<br>key - Name of the Workspace to Create.<br>* allow\_destroy\_plan - Default is true.<br>* auto\_apply - Defualt is false.  Automatically apply changes when a Terraform plan is successful. Plans that have no changes will not be applied. If this workspace is linked to version control, a push to the default branch of the linked repository will trigger a plan and apply.<br>* branch - Default is "master".  The repository branch that Terraform will execute from. Default to master.<br>* description - A Description for the Workspace.<br>* global\_remote\_state - Whether the workspace allows all workspaces in the organization to access its state data during runs. If false, then only specifically approved workspaces can access its state (remote\_state\_consumer\_ids)..<br>* queue\_all\_runs - needs description.<br>* remote\_state\_consumer\_ids - The set of workspace IDs set as explicit remote state consumers for the given workspace.<br>* working\_directory - The Directory of the Version Control Repository that contains the Terraform code for UCS Domain Profiles for this Workspace.<br>* workspace\_type - What Type of Workspace will this Create.  Options are:<br>  - app<br>  - cluster<br>  - policies<br>  - kubeconfig | <pre>map(object(<br>    {<br>      agent_pool_id             = optional(string)<br>      allow_destroy_plan        = optional(bool)<br>      auto_apply                = optional(bool)<br>      branch                    = optional(string)<br>      description               = optional(string)<br>      execution_mode            = optional(string)<br>      global_remote_state       = optional(bool)<br>      queue_all_runs            = optional(bool)<br>      remote_state_consumer_ids = optional(list(string))<br>      speculative_enabled       = optional(bool)<br>      working_directory         = string<br>      workspace_type            = string<br>    }<br>  ))</pre> | <pre>{<br>  "default": {<br>    "allow_destroy_plan": true,<br>    "auto_apply": false,<br>    "branch": "master",<br>    "description": "",<br>    "global_remote_state": false,<br>    "queue_all_runs": false,<br>    "remote_state_consumer_ids": [],<br>    "speculative_enabled": true,<br>    "working_directory": "",<br>    "workspace_type": ""<br>  }<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_tfc_agent_pool"></a> [tfc\_agent\_pool](#output\_tfc\_agent\_pool) | Terraform Cloud Agent Pool ID. |
| <a name="output_workspaces"></a> [workspaces](#output\_workspaces) | Terraform Cloud Workspace IDs and Names. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

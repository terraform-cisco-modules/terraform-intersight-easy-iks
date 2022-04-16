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
* agent_pool (The Name of the Agent Pool in the TFCB Account)
* vcs_repo (The Name of your Version Control Repository. i.e. CiscoDevNet/intersight-tfb-iks)

### Intersight Variables

* apikey
* secretkey

  instructions: <https://community.cisco.com/t5/data-center-documents/intersight-api-overview/ta-p/3651994>

### When assigning the Target Password - It Must match the password used to register the Target in Intersight

* k8s_vm_infra_password

### Generate SSH Key

* ssh_key (Note this must be a ecdsa key type)

  instructions: <https://www.ssh.com/academy/ssh/keygen>

### Import the Variables into your Environment before Running the Terraform Cloud Provider module(s) in this directory

Modify the terraform.tfvars file to the unique attributes of your environment

Once finished with the modification commit the changes to your reposotiry.

The Following examples are for a Linux based Operating System.  Note that the TF_VAR_ prefix is used as a notification to the terraform engine that the environment variable will be consumed by terraform.

* Terraform Cloud Variables

- Linux Example

```bash
export TF_VAR_terraform_cloud_token="your_cloud_token"
export TF_VAR_tfc_oauth_token="your_oath_token"
```

- Windows Example

```bash
$env:TF_VAR_terraform_cloud_token="your_cloud_token"
$env:TF_VAR_tfc_oauth_token="your_oath_token"
```

* Intersight apikey and secretkey

- Linux Example

```bash
export TF_VAR_apikey="your_api_key"
export TF_VAR_secretkey=`cat ~/Downloads/SecretKey.txt`
```

- Windows Example

```powershell
$env:TF_VAR_apikey="your_api_key"
$env:TF_VAR_secretkey="$HOME\Downloads\SecretKey.txt`"
```

* Target Password

- Linux Example

```bash
export TF_VAR_target_password="your_target_password"
```

- Windows Example

```powershell
$env:TF_VAR_target_password="your_target_password"
```

* Kubernetes Cluster ssh_key

- Linux Example

```bash
export TF_VAR_ssh_public_key_1="your_ssh_key"
```

- Windows Example

```powershell
$env:TF_VAR_ssh_public_key_1="your_ssh_key"
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
| <a name="requirement_tfe"></a> [tfe](#requirement\_tfe) | 0.30.2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_tfe"></a> [tfe](#provider\_tfe) | 0.30.2 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [tfe_variable.cluster_variables](https://registry.terraform.io/providers/hashicorp/tfe/0.30.2/docs/resources/variable) | resource |
| [tfe_variable.intersight_variables](https://registry.terraform.io/providers/hashicorp/tfe/0.30.2/docs/resources/variable) | resource |
| [tfe_variable.policies_variables](https://registry.terraform.io/providers/hashicorp/tfe/0.30.2/docs/resources/variable) | resource |
| [tfe_workspace.workspaces](https://registry.terraform.io/providers/hashicorp/tfe/0.30.2/docs/resources/workspace) | resource |
| [tfe_agent_pool.agent_pools](https://registry.terraform.io/providers/hashicorp/tfe/0.30.2/docs/data-sources/agent_pool) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_agent_pools"></a> [agent\_pools](#input\_agent\_pools) | Terraform Cloud Agent Pool List. | `list(string)` | `[]` | no |
| <a name="input_apikey"></a> [apikey](#input\_apikey) | Intersight API Key. | `string` | n/a | yes |
| <a name="input_docker_http_proxy_password"></a> [docker\_http\_proxy\_password](#input\_docker\_http\_proxy\_password) | Password for the Docker HTTP Proxy Server, If required. | `string` | `""` | no |
| <a name="input_docker_https_proxy_password"></a> [docker\_https\_proxy\_password](#input\_docker\_https\_proxy\_password) | Password for the Docker HTTPS Proxy Server, If required. | `string` | `""` | no |
| <a name="input_oauth_token_id"></a> [oauth\_token\_id](#input\_oauth\_token\_id) | Terraform Cloud OAuth Token for VCS\_Repo Integration. | `string` | n/a | yes |
| <a name="input_secretkey"></a> [secretkey](#input\_secretkey) | Intersight Secret Key. | `string` | n/a | yes |
| <a name="input_ssh_public_key_1"></a> [ssh\_public\_key\_1](#input\_ssh\_public\_key\_1) | Intersight Kubernetes Service Cluster SSH Public Key 1. | `string` | `""` | no |
| <a name="input_target_password"></a> [target\_password](#input\_target\_password) | Target Password.  Note: this is the password of the Credentials used to register the Virtualization Target. | `string` | n/a | yes |
| <a name="input_terraform_cloud_token"></a> [terraform\_cloud\_token](#input\_terraform\_cloud\_token) | Token to Authenticate to the Terraform Cloud. | `string` | n/a | yes |
| <a name="input_terraform_version"></a> [terraform\_version](#input\_terraform\_version) | Terraform Target Version. | `string` | `"1.0.3"` | no |
| <a name="input_tfc_organization"></a> [tfc\_organization](#input\_tfc\_organization) | Terraform Cloud Organization Name. | `string` | n/a | yes |
| <a name="input_variable_list"></a> [variable\_list](#input\_variable\_list) | * key - (Required) Name of the variable.<br>* value - (Required) Value of the variable.<br>* category - (Required) Whether this is a Terraform or environment variable. Valid values are terraform or env.<br>* description - (Optional) Description of the variable.<br>* hcl - (Optional) Whether to evaluate the value of the variable as a string of HCL code. Has no effect for environment variables. Defaults to false.<br>* sensitive - (Optional) Whether the value is sensitive. If true then the variable is written once and not visible thereafter. Defaults to false.<br>* value - (Optional) The Value to assign to the variable.<br>* var\_type:<br>  - cluster: Kubernetes Cluster Variables<br>  - intersight: Intersight Variables<br>  - policies: Kubernetes Policy Variables | <pre>list(object(<br>    {<br>      category    = optional(string)<br>      description = optional(string)<br>      key         = string<br>      sensitive   = optional(bool)<br>      value       = optional(string)<br>      var_type    = string<br>    }<br>  ))</pre> | <pre>[<br>  {<br>    "category": "terraform",<br>    "description": "",<br>    "key": "**REQUIRED**",<br>    "sensitive": true,<br>    "value": "",<br>    "var_type": "**REQUIRED**"<br>  }<br>]</pre> | no |
| <a name="input_vcs_repo"></a> [vcs\_repo](#input\_vcs\_repo) | Version Control System Repository. | `string` | n/a | yes |
| <a name="input_workspaces"></a> [workspaces](#input\_workspaces) | * agent\_pool - (Optional) The Name of an agent pool to assign to the workspace. Requires execution\_mode to be set to agent. This value must not be provided if execution\_mode is set to any other value or if operations is provided.<br>* allow\_destroy\_plan - (Optional) Whether destroy plans can be queued on the workspace.<br>* auto\_apply - (Optional) Whether to automatically apply changes when a Terraform plan is successful. Defaults to false.<br>* description - (Optional) A description for the workspace.<br>* execution\_mode - (Optional) Which execution mode to use. Using Terraform Cloud, valid values are remote, local oragent. Defaults to remote. Using Terraform Enterprise, only remoteand local execution modes are valid. When set to local, the workspace will be used for state storage only. This value must not be provided if operations is provided.<br>* file\_triggers\_enabled - (Optional) Whether to filter runs based on the changed files in a VCS push. Defaults to true. If enabled, the working directory and trigger prefixes describe a set of paths which must contain changes for a VCS push to trigger a run. If disabled, any push will trigger a run.<br>* global\_remote\_state - (Optional) Whether the workspace allows all workspaces in the organization to access its state data during runs. If false, then only specifically approved workspaces can access its state (remote\_state\_consumer\_ids).<br>* remote\_state\_consumer\_ids - (Optional) The set of workspace IDs set as explicit remote state consumers for the given workspace.<br>* queue\_all\_runs - (Optional) Whether the workspace should start automatically performing runs immediately after its creation. Defaults to true. When set to false, runs triggered by a webhook (such as a commit in VCS) will not be queued until at least one run has been manually queued. Note: This default differs from the Terraform Cloud API default, which is false. The provider uses true as any workspace provisioned with false would need to then have a run manually queued out-of-band before accepting webhooks.<br>* speculative\_enabled - (Optional) Whether this workspace allows speculative plans. Defaults to true. Setting this to false prevents Terraform Cloud or the Terraform Enterprise instance from running plans on pull requests, which can improve security if the VCS repository is public or includes untrusted contributors.<br>* ssh\_key\_id - (Optional) The ID of an SSH key to assign to the workspace.<br>* structured\_run\_output\_enabled - (Optional) Whether this workspace should show output from Terraform runs using the enhanced UI when available. Defaults to true. Setting this to false ensures that all runs in this workspace will display their output as text logs.<br>* tag\_names - (Optional) A list of tag names for this workspace. Note that tags must only contain letters, numbers or colons.<br>* terraform\_version - (Optional) The version of Terraform to use for this workspace. This can be either an exact version or a version constraint (like ~> 1.0.0); if you specify a constraint, the workspace will always use the newest release that meets that constraint. Defaults to the latest available version.<br>* trigger\_prefixes - (Optional) List of repository-root-relative paths which describe all locations to be tracked for changes.<br>* working\_directory - (Optional) A relative path that Terraform will execute within. Defaults to the root of your repository.<br>* workspace\_type - What Type of Workspace will this Create.  Options are:<br>  - app<br>  - cluster<br>  - policies<br>  - kubeconfig<br>* vcs\_repo - (Optional) Settings for the workspace's VCS repository, enabling the UI/VCS-driven run workflow. Omit this argument to utilize the CLI-driven and API-driven workflows, where runs are not driven by webhooks on your VCS provider.<br>* The vcs\_repo block supports:<br>  - branch - (Optional) The repository branch that Terraform will execute from. This defaults to the repository's default branch (e.g. main).<br>  - identifier - (Required) A reference to your VCS repository in the format <organization>/<repository> where <organization> and <repository> refer to the organization and repository in your VCS provider. The format for Azure DevOps is //\_git/.<br>  - ingress\_submodules - (Optional) Whether submodules should be fetched when cloning the VCS repository. Defaults to false. | <pre>map(object(<br>    {<br>      agent_pool                    = optional(string)<br>      allow_destroy_plan            = optional(bool)<br>      auto_apply                    = optional(bool)<br>      description                   = optional(string)<br>      execution_mode                = optional(string)<br>      file_triggers_enabled         = optional(bool)<br>      global_remote_state           = optional(bool)<br>      queue_all_runs                = optional(bool)<br>      remote_state_consumer_ids     = optional(list(string))<br>      speculative_enabled           = optional(bool)<br>      ssh_key_id                    = optional(string)<br>      structured_run_output_enabled = optional(bool)<br>      tag_names                     = optional(list(string))<br>      terraform_version             = optional(string)<br>      trigger_prefixes              = optional(list(string))<br>      working_directory             = string<br>      workspace_type                = string<br>      vcs_repo = optional(list(object(<br>        {<br>          branch             = optional(string)<br>          identifier         = optional(string)<br>          ingress_submodules = optional(bool)<br>        }<br>      )))<br>    }<br>  ))</pre> | <pre>{<br>  "default": {<br>    "agent_pool": "",<br>    "allow_destroy_plan": true,<br>    "auto_apply": false,<br>    "description": "",<br>    "execution_mode": "remote",<br>    "file_triggers_enabled": true,<br>    "global_remote_state": false,<br>    "queue_all_runs": false,<br>    "remote_state_consumer_ids": [],<br>    "speculative_enabled": true,<br>    "ssh_key_id": "",<br>    "structured_run_output_enabled": true,<br>    "tag_names": [],<br>    "terraform_version": "1.1.8",<br>    "trigger_prefixes": [],<br>    "vcs_repo": [<br>      {<br>        "branch": "",<br>        "identifier": "**REQUIRED**",<br>        "ingress_submodules": false<br>      }<br>    ],<br>    "working_directory": "",<br>    "workspace_type": "**REQUIRED**"<br>  }<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_tfc_agent_pool"></a> [tfc\_agent\_pool](#output\_tfc\_agent\_pool) | Terraform Cloud Agent Pool ID. |
| <a name="output_workspaces"></a> [workspaces](#output\_workspaces) | Terraform Cloud Workspace IDs and Names. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

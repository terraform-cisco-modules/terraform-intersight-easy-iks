# Kubernetes Applications - Hello Kubernetes

## Use this module to deploy the Hello Kubernetes Application through the Intersight Assist Appliance

Run the plan from the Terraform cloud workspace.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_helm"></a> [helm](#provider\_helm) | n/a |
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [helm_release.hello_iks_app](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [terraform_remote_state.local_kubeconfigs](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.remote_kubeconfigs](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Name of the Cluster to push Policy to | `string` | n/a | yes |
| <a name="input_tfc_workspaces"></a> [tfc\_workspaces](#input\_tfc\_workspaces) | * backend: Options are:<br>  - local - The backend is on the Local Machine<br>  - Remote - The backend is in TFCB.<br>* kubeconfig\_dir: Name of the Policies directory when the backend is local.<br>* organization: Name of the Terraform Cloud Organization when backend is remote.<br>* workspace: Name of the workspace in Terraform Cloud. | <pre>list(object(<br>    {<br>      backend        = string<br>      kubeconfig_dir = optional(string)<br>      organization   = optional(string)<br>      workspace      = optional(string)<br>    }<br>  ))</pre> | <pre>[<br>  {<br>    "backend": "remote",<br>    "kubeconfig_dir": "../kubeconfigs/",<br>    "organization": "default",<br>    "workspace": "kubeconfigs"<br>  }<br>]</pre> | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

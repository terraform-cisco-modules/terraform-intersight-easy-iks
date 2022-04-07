# Kubernetes Applications - IWO

## Use this module to deploy Intersight Workload Optimizer through the Intersight Assist Appliance

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
| [helm_release.iwo_k8s_collector](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [terraform_remote_state.local_kubeconfig](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.remote_kubeconfig](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_tfc_workspaces"></a> [tfc\_workspaces](#input\_tfc\_workspaces) | * backend: Options are:<br>  - local - The backend is on the Local Machine<br>  - Remote - The backend is in TFCB.<br>* kubeconfig\_dir: Name of the Policies directory when the backend is local.<br>* organization: Name of the Terraform Cloud Organization when backend is remote.<br>* workspace: Name of the workspace in Terraform Cloud. | <pre>list(object(<br>    {<br>      backend      = string<br>      organization = optional(string)<br>      policies_dir = optional(string)<br>      workspace    = optional(string)<br>    }<br>  ))</pre> | <pre>[<br>  {<br>    "backend": "remote",<br>    "organization": "default",<br>    "policies_dir": "../kubeconfig/",<br>    "workspace": "kubeconfig"<br>  }<br>]</pre> | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

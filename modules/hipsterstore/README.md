# Kubernetes Applications - Hello Kubernetes

## Use this module to deploy the Hello Kubernetes Application through the Intersight Assist Appliance

Run the plan from the Terraform cloud workspace.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_kubectl"></a> [kubectl](#requirement\_kubectl) | 1.11.3 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_kubectl"></a> [kubectl](#provider\_kubectl) | 1.11.3 |
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [kubectl_manifest.hipster](https://registry.terraform.io/providers/gavinbunney/kubectl/1.11.3/docs/resources/manifest) | resource |
| [terraform_remote_state.local_kubeconfig](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.remote_kubeconfig](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_tfc_workspaces"></a> [tfc\_workspaces](#input\_tfc\_workspaces) | * backend: Options are:<br>  - local - The backend is on the Local Machine<br>  - Remote - The backend is in TFCB.<br>* kubeconfig\_dir: Name of the Policies directory when the backend is local.<br>* organization: Name of the Terraform Cloud Organization when backend is remote.<br>* workspace: Name of the workspace in Terraform Cloud. | <pre>list(object(<br>    {<br>      backend      = string<br>      organization = optional(string)<br>      policies_dir = optional(string)<br>      workspace    = optional(string)<br>    }<br>  ))</pre> | <pre>[<br>  {<br>    "backend": "remote",<br>    "organization": "default",<br>    "policies_dir": "../kubeconfig/",<br>    "workspace": "kubeconfig"<br>  }<br>]</pre> | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

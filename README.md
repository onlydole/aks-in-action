# AKS in Action

> Deploying the Azure Kubernetes Service (AKS) with Terraform

## Table of Contents

- [AKS in Action](#aks-in-action)
  - [Table of Contents](#table-of-contents)
  - [Requirements](#requirements)
    - [Before you apply](#before-you-apply)
  - [Additional Reading](#additional-reading)
  - [Author Information](#author-information)
  - [License](#license)

## Requirements

To use the code in this repository, you will need the following applications:

- [HashiCorp Terraform](https://www.terraform.io/downloads.html) `1.9.0` (or later)
- [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/) `2.29.0` (or later)

This configuration uses the AzureRM provider `4.x`, which needs a subscription ID. Set it before you run `terraform plan`, for example with `export ARM_SUBSCRIPTION_ID="$(az account show --query id -o tsv)"`.

### Before you apply

- **Kubernetes version.** `cluster_version` defaults to `1.36`, and AKS runs the latest GA patch of that minor. New minors don't reach every region on the same day. Check what your region offers and override the default when you need to.

  ```shell
  az aks get-versions --location westus --output table
  terraform apply -var="cluster_version=1.37"
  ```

- **Subnet permissions.** The cluster uses kubenet, a system-assigned managed identity, and the `subnet1` subnet from this configuration. AKS needs that identity to hold at least the [Network Contributor](https://learn.microsoft.com/en-us/azure/aks/configure-kubenet) role on the subnet. Terraform doesn't create that role assignment for you. Once the cluster exists, grant it with this command.

  ```shell
  az role assignment create \
    --assignee "$(az aks show -g aks-in-action -n aks-in-action-aks --query identity.principalId -o tsv)" \
    --role "Network Contributor" \
    --scope "$(az network vnet subnet show -g aks-in-action --vnet-name acctvnet -n subnet1 --query id -o tsv)"
  ```

  You can also set `create_role_assignment_network_contributor = true` on `module.aks`. That only works if the identity running Terraform has Owner, User Access Administrator, or Role Based Access Control Administrator, because Contributor can't create role assignments.

### Additional Reading

- Creating Terraform resources: [learn.hashicorp.com/tutorials/terraform/azure-dependency](https://learn.hashicorp.com/tutorials/terraform/azure-dependency?in=terraform/azure-get-started)
- Terraform Remote State: [learn.hashicorp.com/tutorials/terraform/azure-remote](https://learn.hashicorp.com/tutorials/terraform/azure-remote?in=terraform/azure-get-started)
- Provisioning AKS Clusters: [learn.hashicorp.com/tutorials/terraform/aks](https://learn.hashicorp.com/tutorials/terraform/aks?in=terraform/kubernetes)
- Managing Kubernetes resources: [learn.hashicorp.com/tutorials/terraform/kubernetes-provider](https://learn.hashicorp.com/tutorials/terraform/kubernetes-provider?in=terraform/kubernetes)

## Author Information

This repository is maintained by [Taylor Dolezal](https://github.com/onlydole)

## License

Licensed under the Apache License, Version 2.0 (the "License").

You may obtain a copy of the License at [apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0).

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an _"AS IS"_ basis, without WARRANTIES or conditions of any kind, either express or implied.

See the License for the specific language governing permissions and limitations under the License.

# HCP Terraform stacks demo for Spacelift blog post

## Prerequisites

* An HCP Terraform organization
* Add your VCS provider to HCP Terraform
* Make a copy of this repository
* Download the Terraform stacks CLI ([documentation](https://developer.hashicorp.com/terraform/language/stacks/reference/tfstacks-cli))
* AWS CLI credentials available in your terminal
* HCP Terraform credentials available in your terminal (run `terraform login`)
* Download an **alpha**-release version of Terraform and make sure it is in your `$PATH` before your normal Terraform binary. Downloads are available [here](https://releases.hashicorp.com/terraform/)

## Steps to set up the demo

1. Set up the trust relationship between AWS and HCP Terraform by deploying the code in [setup](./setup/).
1. Copy the AWS IAM role ARN output from the previous step and add it to the `locals` block in [deployments.tfdeploy.hcl](deployments.tfdeploy.hcl).
1. Run `tfstacks init`
1. Run `terraform version -json | jq -r .terraform_version > .terraform-version` (or equivalent on Windows) to create a file with the alpha-release version number of Terraform you are using.
1. Commit the new file updates to your git repo, then follow the steps in the blog post to create the Terraform stack on HCP Terraform.
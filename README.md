# Steps

```console
$ tfstacks init
Success! Configuration has been initialized and more commands can now be executed.

$ terraform version -json | jq -r .terraform_version > .terraform-version

$ tfstacks validate
Success! Terraform Stacks configuration is valid and ready for use within HCP Terraform.
```
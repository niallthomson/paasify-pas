# What do we have here?

Terraform. Lots of Terraform. Each example will provision infrastrastructure within an IAAS that's needed for deploying Pivotal Application Service (PAS).

Currently, this code is designed with feature flags that enable different configurations. In the future, we're looking to refactor each configuration option into distinct `example` directories, removing the need for control variables (e.g. `internetless=true`).

The goal of this repo is to provide the base level configurations
we think the majority of use cases will require.

If you have some sort of specialized need, try to tackle it by
creating your own modules / overrides to layer on top of
what currently exists.

# Structure

This repo has a couple of sections split out by IAAS.
```
|-- aws
|   |-- addons - space for addons you can apply
|   |-- examples - runnable terraform files that will create infrastructure
|   |-- modules - reusable pieces that we compose into examples
|   |-- overrides - space for common overrides you can apply
|-- gpc
|   | ...
|-- azure
|   | ...
|-- ci - for development only
```

# Prerequisites

Install the latest version of the [Terraform CLI](https://www.terraform.io/downloads.html).

```bash
brew update
brew install terraform
```

# Deploying Infrastructure

Each example can be run as is using the following instructions:

1. `cd` into the proper {IAAS}/examples/{configuration} directory
1. Add override/addon terraform files.
1. Create required values from the `variables.tf`. Please see their descriptions
   for more information.
1. Run `terraform`.

  ```bash
  terraform init
  terraform apply
  ```



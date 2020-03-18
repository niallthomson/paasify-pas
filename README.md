# Paasify for Pivotal Application Service

![](https://github.com/niallthomson/paasify-pas/workflows/CI/badge.svg)

Install Pivotal Application Service with nothing more than Terraform. If you need fire-and-forget mechanism that gives you predictable, disposable PAS environments (including many popular tiles) in your own cloud accounts then this is for you.

The goal of this project is to allow you to complete an install of PAS, including optional tiles, with the only requirement being Terraform. This is being essentially being exposed as 'PAS-as-a-Terraform-module' that is compatible across all supported public clouds. It is designed for short-term, non-production setups, and is not intended to provide a PAS setup that can be upgraded over long periods of time.

| AWS | GCP | Azure | VMware |
|------|-----|-----|-----|
| [Docs](docs/modules/aws.md) | [Docs](docs/modules/gcp.md) | :x: | :x: |

Note: This project requires Terraform 0.12.X

Take this example:

```
module "pas" {
  source = "github.com/niallthomson/paasify-pas//aws"

  env_name     = "paasify-test"
  dns_suffix   = "aws.paasify.org"
  pivnet_token = "<pivnet token here>"

  pas_version  = 2.8

  region             = "us-west-2"
  availability_zones = ["us-west-2a", "us-west-2b", "us-west-2c"]

  tiles = ["mysql"]
}

output "opsman_url" {
  value = "https://${module.pas.ops_manager_domain}"
}

output "opsman_username" {
  value = module.pas.ops_manager_username
}

output "opsman_password" {
  value = module.pas.ops_manager_password
}

output "cf_api_endpoint" {
  value = module.pas.cf_api_endpoint
}

output "cf_apps_manager_endpoint" {
  value = module.pas.cf_apps_manager_endpoint
}
```

This will:
- Install PAS 2.8 Small Footprint
- Download, stage and configure the MySQL tile
- Wire up DNS so that its accessible at `paasify-test.aws.paasify.org`
- Provision valid SSL certificates via Lets Encrypt for every common HTTPS endpoint
- Allow you to cleanly tear down all infrastructure via `terraform destroy`
- Perform all PivNet product downloads/uploads on a jumpbox VM for speed

When the Terraform run completes there will be a fully working PAS installation, with endpoint information available from Terraform outputs.

## Reference

Quick reference for various areas of the project.

### Prerequisites

The following are pre-requisites for working with Paasify:
- Understand how to provide cloud credentials, which is documented [here](https://github.com/niallthomson/paasify-core/blob/master/docs/handling-cloud-credentials.md).
- DNS setup appropriately for your cloud of choice. See [here](https://github.com/niallthomson/paasify-core/blob/master/docs/dns-setup.md) for details on how your DNS should be setup.
- Terraform 0.12.X installed

### Comparison with legacy pcf-paasify

If you've come from `pcf-paasify` then see [here](docs/legacy-paasify-diff.md) for how this project differs.

### Tiles

The following table lists all tiles that can be automatically installed, along with the name that should be put in the `tiles` parameter:

| Tile | Name| 2.6 | 2.7 | 2.8 |
|------|-----|-----|-----|-----|
| MySQL | `mysql` | :white_check_mark: | :white_check_mark: | :white_check_mark: |
| RabbitMQ | `rabbitmq` | :white_check_mark: | :white_check_mark: | :white_check_mark: |
| Redis | `redis` | :white_check_mark: | :white_check_mark: | :white_check_mark: |
| Spring Cloud Services | `scs` | :white_check_mark: | :white_check_mark: | :white_check_mark: |
| Spring Cloud Gateway | `gateway` | :white_check_mark: | :white_check_mark: | :white_check_mark: |
| Single Sign-On | `sso` | :white_check_mark: | :white_check_mark: | :white_check_mark: |

The latest stemcell supported by each tile will automatically be uploaded to OpsManager.

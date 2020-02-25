# Paasify for Pivotal Application Service

Installing Pivotal Application Service for quick setups can be more complicated than it should. The goal of this project is to allow you to complete an install of PAS, with optional tiles, with nothing more than Terraform installed locally. This is being essentially being exposed as 'PAS-as-a-Terraform-module' that is compatible across all supported public clouds. It is designed for short-term, non-production setups, and is not intended to provide a PAS setup that can be upgraded over long periods of time.

Note: This project requires Terraform 0.12

If you need fire-and-forget mechanism that gives you predictable, disposable PAS environments (including many popular tiles) then this is for you.

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
```

This will:
- Install PAS 2.8 Small Footprint
- Download, stage and configure the MySQL, RabbitMQ and Spring Cloud Services tiles
- Wire up DNS so that its accessible at `paasify-test.aws.paasify.org`
- Provision valid SSL certificates via Lets Encrypt for every common HTTPS endpoint
- Allow you to cleanly tear down all infrastructure via `terraform destroy`
- Perform all PivNet product downloads/uploads on a jumpbox VM for speed

When the Terraform run completes there will be a fully working PAS installation, with endpoint information available from Terraform outputs.

## Reference

Various bits of information.

### Tiles

The following table lists all tiles that can be automatically installed, along with the name that should be put in the `tiles` parameter:

| Tile | Version | Name |
|------|-----|-----|
| tbd | tbd | tbd |

The latest stemcell supported by each tile will automatically be uploaded to OpsManager.
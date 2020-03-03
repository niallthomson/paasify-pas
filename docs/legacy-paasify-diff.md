# Comparison with legacy pcf-paasify

There are many differences between this project and the legacy `pcf-paasify` project that you may have used before. There are architectural improvements which have led to a number of initial improvements, which will change over time.

The main high-level changes are:
- No more branch-per-PAS-release model, instead all supported PAS versions are built on a single branch
- Move from Terraform 0.11.X to 0.12.X
- Modularization of functions, which will allow things like adding custom tiles easier
- No longer rely on `terraforming-*` projects, instead taking full control of underlying IaaS paving configuration
- Separate 'provisioner' jumpbox/bastion host is used to run things like `om` commands instead of running on OpsManager host

There are additional planned improvements that are unlocked by the redesign, including:
- Upgrade OpsManager, PAS and tiles between major versions
- Pass custom configuration ops files to tiles, including reconfiguration over iterative runs of `terraform apply`
- Repave entire foundations with latest stemcells after initial install
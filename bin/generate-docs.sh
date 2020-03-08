#!/bin/bash

set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

cat << EOF > $DIR/../docs/modules/aws.md
# Paasify PAS on AWS
This module installs Pivotal Application Service on AWS.
EOF
terraform-docs --no-providers markdown document aws >> $DIR/../docs/modules/aws.md

echo -e '# Paasify PAS on GCP\n' > $DIR/../docs/modules/gcp.md
terraform-docs --no-providers markdown document gcp >> $DIR/../docs/modules/gcp.md
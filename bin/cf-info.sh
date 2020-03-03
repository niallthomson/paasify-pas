#!/bin/bash

set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

source $DIR/core/opsman-env.sh

cf_api_endpoint=$(terraform output cf_api_endpoint)
cf_admin_password=$(om credentials -p cf -c .uaa.admin_credentials -t json | jq -r '.password')

echo "OpsManager information"
echo ""
echo "API Endpoint: ${cf_api_endpoint}"
echo "Username: admin"
echo "Password: ${cf_admin_password}"
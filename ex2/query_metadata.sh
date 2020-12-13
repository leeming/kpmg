#!/bin/bash
set -euf -o pipefail

METADATA="/run/cloud-init/instance-data.json"

# Check if metadata file exists
test -f ${METADATA} || { echo >&2 "This script needs to be run on a cloud image that supports cloudinit"; exit 1; }

if [ $# -eq 1 ]; then
    # Check if JQ is installed (only for selecting keys)
    command -v jq >/dev/null 2>&1 || { echo >&2 "JQ needs to be installed if you want to search the metadata"; exit 1; }

    cat ${METADATA} | jq '.ds."meta-data".'$1

else
    cat ${METADATA} | jq '.ds."meta-data"'
fi



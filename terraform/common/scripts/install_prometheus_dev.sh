#!/bin/bash

set -e

om_username=$1
om_password=$2

filename="prometheus-0.1.0.pivotal"

export OM_USERNAME=$om_username
export OM_PASSWORD=$om_password

if [ ! -f "$filename" ]; then
  echo "Downloading Prometheus Dev tile..."
  wget https://storage.googleapis.com/prometheus-tile-dev/$filename
fi

om -k -t https://localhost upload-product -p $filename

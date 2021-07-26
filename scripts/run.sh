#!/bin/bash
RAND=$(uuidgen -r | awk -F '-' {'print $1'} | rev | cut -c 4- | rev)
cluster_id=$3
cluster_nodes=$4

# configure aws-cli
mkdir ~/.aws
echo "[default]" >> ~/.aws/credentials
echo "aws_access_key_id = $1" >> ~/.aws/credentials
echo "aws_secret_access_key = $2" >> ~/.aws/credentials
echo "[default]" >> ~/.aws/config
echo "region = us-east-2" >> ~/.aws/config

# configure rosa
rosa login --token="$5"

# download the newest oc
rosa download oc
tar xvzf openshift-client-linux.tar.gz
mv oc /usr/local/bin
mv kubectl /usr/local/bin

# verify aws and rosa configuration
rosa init

# request rosa
rosa create cluster --cluster-name ${cluster_id}-${RAND} --region us-east-2 --version 4.7.19 --compute-nodes ${cluster_nodes} --machine-cidr 10.0.0.0/16 --service-cidr 172.30.0.0/16 --pod-cidr 10.128.0.0/14 --host-prefix 23

# output logs
rosa logs install -c ${cluster_id}-${RAND} --watch

# create output logs
rosa create idp --cluster=${cluster_id}-${RAND} --type openid --client-id $6 --client-secret $7 --name IBMid --username-claims username --name-claims name --email-claims email --issuer-url $8




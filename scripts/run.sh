#!/bin/bash
RAND=$(uuidgen -r | awk -F '-' {'print $1'} | rev | cut -c 4- | rev)
CLUSTER_ADMIN_PASSWORD="IBM0penShift"
cluster_id=$3
cluster_nodes=$4
cluster_type_value="m5.xlarge"
cluster_type=${9:-$cluster_type_value}

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
rosa create cluster --cluster-name ${cluster_id}-${RAND} --region us-east-2 --version 4.7.19 --compute-nodes ${cluster_nodes} --compute-machine-type ${cluster_type} --machine-cidr 10.0.0.0/16 --service-cidr 172.30.0.0/16 --pod-cidr 10.128.0.0/14 --host-prefix 23

# output logs
rosa logs install -c ${cluster_id}-${RAND} --watch

# create ibmid idp
rosa create idp --cluster=${cluster_id}-${RAND} --type openid --client-id $6 --client-secret $7 --name IBMid --username-claims username --name-claims name --email-claims email --issuer-url $8

# create the rosa kube-admin
echo "going to wait 600 seconds for cluster to come up fully"
sleep 600
rosa create admin --cluster=${cluster_id}-${RAND} > cluster-admin.sh
grep oc cluster-admin.sh > oc.sh
bash -x oc.sh
sleep 30
bash -x oc.sh
sleep 30
bash -x oc.sh
sleep 30
bash -x oc.sh
oc extract secret/htpasswd-secret -n openshift-config --to /tmp --confirm
sleep 30
htpasswd -b -B /tmp/htpasswd cluster-admin ${CLUSTER_ADMIN_PASSWORD}
sleep 30
oc set data secret/htpasswd-secret -n openshift-config --from-file htpasswd=/tmp/htpasswd
sleep 30
oc set data secret/htpasswd-secret -n openshift-config --from-file htpasswd=/tmp/htpasswd
sleep 30
oc set data secret/htpasswd-secret -n openshift-config --from-file htpasswd=/tmp/htpasswd
sleep 30
oc set data secret/htpasswd-secret -n openshift-config --from-file htpasswd=/tmp/htpasswd

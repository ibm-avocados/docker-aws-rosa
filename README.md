# docker aws rosa

## Scope

A simple docker container that has everything required to request a ROSA instance from AWS.

**EXAMPLE**:
```bash
docker run quay.io/ibm-avocados/docker-aws-rosa:latest "AWS_CLIENT_KEY" "AWS_SECRET_KEY" "CLUSTER_NAME" "COMPUTE_NODES" "ROSA_TOKEN" "OPENID_CLIENT_ID" "OPENID_CLIENT_SECRET" "ISSUER_URL" "OPT:SIZE_OVERRIDE"
```
Look at [here](https://aws.amazon.com/ec2/instance-types/) if you want to do the "OPT:SIZE_OVERRIDE"

## License & Authors

If you would like to see the detailed LICENCE click [here](https://raw.githubusercontent.com/jjasghar/COBOL-on-k8s/master/LICENCE).

- Author: JJ Asghar <awesome@ibm.com>
- Co-Author: Oliver Rodriguez <odrodrig@us.ibm.com>
- Co-Author: Jeremy Alcanzare <jeremy.alcanzare@ibm.com>


```text
Copyright:: 2021- IBM, Inc

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```

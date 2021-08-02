# Quay deployment with quay-operator
Quay operator expects to have object storage for the quay registry. In this case here we're providing storage via minIO.
## minIO storage setup
### Create a directory to be used by minIO
```
# mkdir /minio-data
```
### Start the minIO server pod
```
# podman run -d -p 9000:9000 --name minio -e MINIO_ROOT_USER=<MINIO_ROOT_USER> -e MINIO_ROOT_PASSWORD=<MINIO_ROOT_PASSWORD> -v /minio-data:/data:Z docker.io/minio/minio server /data
```
### Start the minIO client to set up storage
```
# podman run -it --entrypoint=/bin/sh docker.io/minio/mc
```
#### Setting an alias to the minIO server
```
# mc alias set minio http://<MINIO_SERVERNAME_OR_IP>:9000 <MINIO_ROOT_USER> <MINIO_ROOT_PASSWORD> --api S3v4
```
#### Create a bucket `quay`
```
# mc mb minio/quay
```
#### List the content
```
# mc tree -f minio
```
### Exit the minIO client pod
```
# exit
```
## Install the quay-operator
### Create the file e.g. `subscription-quay-operator.v3.4.yaml`
For automatic approval change `installPlanApproval` from `Manual` to `Automatic`
```
---
apiVersion: operators.coreos.com/v1alpha1
kind: Subscription
metadata:
  name: quay-operator
  namespace: openshift-operators
spec:
  channel: quay-v3.4
  installPlanApproval: Manual
  name: quay-operator
  source: redhat-operators
  sourceNamespace: openshift-marketplace
  startingCSV: quay-operator.v3.4.3
...
```
### Install the quay-operator
```
oc create -f subscription-quay-operator.v3.4.yaml
```
### Check the operator install phase
```
oc get csvs
```
### Get the installplan status
```
oc get ip -n openshift-operators
```
### Approve the installplan
```
oc patch ip <INSTALLPLANNAME> --namespace openshift-operators --type merge --patch '{"spec": {"approved": true}}'
```
### Monitor the operator install phase
```
watch oc get csvs -n openshift-operators
```
### Check if there are more installplans to approve
```
oc get ip -n openshift-operators
```
Approve them if necessary in the way described above

## Prepare the quay registry setup files
### Create quay `config.yaml` configuration file to use the minIO storage
```
FEATURE_STORAGE_REPLICATION: true
DISTRIBUTED_STORAGE_CONFIG:
  default:
  - RadosGWStorage
  - access_key: <USERNAME>
    bucket_name: <BUCKETNAME>
    hostname: <SERVERFQDN_OR_IP>
    is_secure: false
    port: '<PORT>'
    secret_key: <PASSWORD>
    storage_path: /datastorage/registry
DISTRIBUTED_STORAGE_DEFAULT_LOCATIONS:
- default
DISTRIBUTED_STORAGE_PREFERENCE:
- default
FEATURE_USER_CREATION: true
REGISTRY_TITLE: <REGISTRY_TITLE>
SUPER_USERS:
  - <SUPERUSERNAME>
SERVER_HOSTNAME: <REGISTRY_FQDN>
```
### Create the quayregistry CR `quayregistry.yaml` (to use the defined minIO storage above set `kind: objectstorage` to `managed: false`)
```
---
apiVersion: quay.redhat.com/v1
kind: QuayRegistry
metadata:
  name: quay-registry
  namespace: quay-enterprise
spec:
  configBundleSecret: quay-config-bundle
  components:
    - managed: true
      kind: clair
    - managed: true
      kind: postgres
    - managed: false
      kind: objectstorage
    - managed: true
      kind: redis
    - managed: true
      kind: horizontalpodautoscaler
    - managed:true
      kind: route
    - managed: true
      kind: mirror
...
```
### Create the secret `quay-config-bundle` that contains the config.yaml for quay
```
oc create secret generic quay-config-bundle --from-file config.yaml=./config.yaml -n quay-enterprise
```
## Install the quay registry
### Create a project e.g. `quay-enterprise`
```
# oc create new-project quay-enterprise
```
### Deploy the quay registry
```
oc create -f quayregistry.yaml
```
### Watch the deployment
```
watch oc get all,cm,secret -n quay-enterprise
```
This takes 3 - 12 minutes

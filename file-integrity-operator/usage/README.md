# Working with File Integrity

#### Create a FileIntegerity custom resource
```
oc create -f fileintegrity-worker.yaml
```

#### Check the FileIntegerity custom resource state
```
oc get fileintegrities worker-fileintegrity -o template='{{.metadata.name}}{{"\t"}}{{.status.phase}}{{"\n"}}'
```
If it is `Acitve` it's up and running
 
If it is `Initializing` AIDE is initialising it's database

#### Checking the scan results
```
oc get fileintegritynodestatus
```
If the status is `Succeeded` AIDE found nothing suspicious

If the status is `Failed` AIDE found some modified items

> FileIntegrityNodeStatus are created the first time after the second run of the scanner is finished. By default after 15 minutes!

#### Get the configmap name that contains the AIDE report
```
oc get fileintegritynodestatuses.fileintegrity.openshift.io -ojsonpath='{.items[*].results}' | jq
```
Search for the key `resultConfigMapName`


#### Get the AIDE report
```
oc describe cm aide-ds-compute-fileintegrity-<NODE-NAME>.<CLUSTER-DOMAIN>-failed
```

#### Reinitializing the database
 If it was a planned change reinitialize the database
 ```
 oc annotate fileintegrities/compute-fileintegrity file-integrity.openshift.io/re-init=
 ```

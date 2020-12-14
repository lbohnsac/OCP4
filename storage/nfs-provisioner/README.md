# NFS-PROVISIONER 
###### (tested with nfs-provisioner v3.1.0-k8s1.11 on OCP 4.4.x and OCP 4.5.x)

## Prerequisites
We need a NFS server with a configured export (allowed to write for all cluster nodes and 777 as permission)

e.g.
- NFS server IP:  192.168.0.1
- Export name:    /nfs-storage

## Deploying the nfs provisioner

#### Create project `openshift-nfs-provisioner`
```
# oc create -f project-openshift-nfs-provisioner.yaml
```

#### Create clusterrole `nfs-client-provisioner-runner`
```
# oc create -f  clusterrole.yaml 
```

#### Create clusterrolebinding `run-nfs-client-provisioner`
```
# oc create -f clusterrolebinding.yaml 
```

#### Create serviceaccount `nfs-client-provisioner`
```
# oc create serviceaccount.yaml
```

#### Create role `leader-locking-nfs-client-provisioner`
```
# oc create -f role.yaml
```

#### Create rolebinding `leader-locking-nfs-client-provisioner`
```
# oc create -f rolebinding.yaml
```

#### Replace the placeholders in the deployment.yaml
- <IP_OR_FQDN_OF_NFS-SERVER>      e.g. 192.168.0.1 
- <EXPORT_OF_NFS-SERVER>          e.g. /nfs-storage

> Use as delimiter the octothorp (#) for the second sed command because of the / in the replacement string
```
# sed -i 's/<IP_OR_FQDN_OF_NFS-SERVER>/192.168.0.1/' deployment.yaml
# sed -i 's#<EXPORT_OF_NFS-SERVER>#/nfs-storage#' deployment.yaml
```

#### Create the deployment `nfs-client-provisioner`
```
# oc create -f deployment.yaml
```
#### Create the storage class `managed-nfs-storage`
```
# oc create -f storageclass.yaml
```

## Testing the deployment

#### Create the pvc `test-claim`
```
# oc create -f pvc-test-claim.yaml
```

#### Check if the pvc is existing and the status is BOUND
```
# oc get pvc test-claim
```

#### Create the pod `test-claim` that will consume the pvc `test-claim` and creates a file named SUCCESS to the nfs storage
```
# oc create -f pod-test-claim.yaml
```

#### Check the existence of the file SUCCESS on the nfs file system

## Clean up

#### Delete the pvc `test-claim`
```
# oc delete pvc test-claim
```

#### Delete the pod `test-claim`
```
# oc delete pod test-claim
```

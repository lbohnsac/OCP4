# Install the local-storage-operator (new since 4.4.3)

#### Create the namespace local-storage
```
oc create -f namespace-local-storage.yaml
```

#### Create the Operatorgroup
```
oc create -f operatorgroup-local-storage.yaml
```

#### Check which software version of the operator is available
```
oc get packagemanifest local-storage-operator -n openshift-marketplace -o jsonpath='{.status.defaultChannel}'
```

#### Replace <SOFTWARE-VERSION> in subscription-local-storage.yaml and create it
```
oc create -f subscription-local-storage.yaml
```

#### Verify the installation
```
oc get pods -n local-storage
```

#### Check the ClusterServiceVersion (csvs) manifest
```
oc get csvs -n local-storage
```

# Install the local-storage-operator (4.7)

#### Create the namespace local-storage
```
oc create -f namespace-openshift-local-storage.yaml
```

#### Create the Operatorgroup
```
oc create -f operatorgroup-openshift-local-storage.yaml
```

#### Check which software version of the operator is available
```
oc get packagemanifest local-storage-operator -n openshift-marketplace \
  --template='{{range .status.channels}}{{.name}}{{"\n"}}{{end}}'
```
###### Modify the following value
SOFTWARE-VERSION

in subscription-local-storage.yaml

Pick the same version as your cluster
```
sed -i 's/<SOFTWARE-VERSION>/<VERSION YOU PICKED>/' subscription-local-storage.yaml
```
#### Create the subscription
```
oc create -f subscription-local-storage.yaml
```

#### Verify the installation
```
oc get pods -n openshift-local-storage
```

#### Check the ClusterServiceVersion (csvs) manifest
```
oc get csvs -n openshift-local-storage
```

# Install the file-integrity-operator (new since 4.6)

#### Create the namespace openshift-file-integrity
```
oc create -f namespace-file-integrity.yaml
```

#### Create the Operatorgroup
```
oc create -f operatorgroup-file-integrity.yaml
```

#### Check which software version of the operactor is available
```
oc get packagemanifest file-integrity-operator -n openshift-marketplace \
  --template='{{range .status.channels}}{{.name}}{{"\n"}}{{end}}'
  ```
  ###### Modify the following value
  SOFTWARE-VERSION

  in subscription-local-storage.yaml

  Pick the same version as your cluster
  ```
  sed -i 's/<SOFTWARE-VERSION>/<VERSION YOU PICKED>/' operator-subscription-es.yaml
  ```
  #### Create the subscription
  ```
  oc create -f subscription-local-storage.yaml
  ```

  #### Watch the installation
  ```
  watch -n 1 -d oc get csvs -n openshift-file-integrity
  ```

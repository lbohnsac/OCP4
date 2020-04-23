```
oc get packagemanifest elasticsearch-operator -n openshift-marketplace -o jsonpath='{.status.defaultChannel}'
```
```
oc get packagemanifest cluster-logging -n openshift-marketplace -o jsonpath='{.status.defaultChannel}'
```

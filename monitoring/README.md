# Install monitoring (elasticsearch)

## Create namespace 
```
oc create -f namespace-es.yaml
```
## Create operatorgroup
```
oc create -f operatorgroup-es.yaml
```
## Check available software-version of the operator
```
oc get packagemanifest elasticsearch-operator -n openshift-marketplace \
-o jsonpath='{.status.defaultChannel}'
```
#### Modify the following value
SOFTWARE-VERSION

in operator-subscription-es.yaml

## Create subscription
```
oc create -f operator-subscrion-es.yaml
```
## Create rbac for es
```
oc create -f rbac-es.yaml
```
## Configure monitoring via the configmap 
```
oc create -f configmap-cluster-monitoring-config.yaml
```
or if infra nodes are available
```
oc create -f configmap-cluster-monitoring-config-on-infras.yaml
```

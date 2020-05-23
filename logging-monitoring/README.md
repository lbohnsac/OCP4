# Install logging (elasticsearch)

#### Create namespace
```
oc create -f namespace-logging.yaml
```
#### Create operatorgroup
```
oc create -f operatorgroup-logging.yaml
```
#### Check available software-version of the operator
```
oc get packagemanifest cluster-logging -n openshift-marketplace -o jsonpath='{.status.defaultChannel}'
```
###### Modify the following value
SOFTWARE-VERSION

in operator-subscription-logging.yaml
#### Create subscription
```
oc create -f operator-subscrion-loggging.yaml
```
#### Check operator installation
```
oc get clusterserviceversion
```
```
oc get pods -n openshift-logging
```
```
oc get crd | grep -e clusterloggings
```

#### Deploy cluster logging components 
```
oc create -f custom-resource-definition-logging.yaml
```
or if infra nodes are available
```
oc create -f custom-resource-definition-logging-on-infras.yaml
```

#### Check the deploymant
```
watch oc get pods -o wide -n openshift-logging
```

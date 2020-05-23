# Install logging and monitoring

#### Create namespaces
```
oc create -f namespace-es.yaml
```
```
oc create -f namespace-logging.yaml
```
#### Create operatorgroups
```
oc create -f operatorgroup-es.yaml
```
```
oc create -f operatorgroup-logging.yaml
```
#### Check available software-version of the operators
```
oc get packagemanifest elasticsearch-operator -n openshift-marketplace -o jsonpath='{.status.defaultChannel}'
```
```
oc get packagemanifest cluster-logging -n openshift-marketplace -o jsonpath='{.status.defaultChannel}'
```
###### Modify the following value
SOFTWARE-VERSION

in operator-subscription-logging.yaml
and 
in operator-subscription-es.yaml

#### Create subscriptions
```
oc create -f operator-subscrion-es.yaml
```
```
oc create -f operator-subscrion-loggging.yaml
```

#### Create Role-based Access Control (RBAC) for Prometheus
```
oc create -f rbac-es.yaml
```

#### Check operator installation
```
oc get clusterserviceversion
```
```
oc get pods -n openshift-operators-redhat
```
```
oc get pods -n openshift-logging
```
```
oc get crd | grep -e clusterloggings -e elasticsearches
```

#### Configure monitoring via the configmap
```
oc create -f configmap-cluster-monitoring-config.yaml
```
or if infra nodes are available
```
oc create -f configmap-cluster-monitoring-config-on-infras.yaml
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

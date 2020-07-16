# Infrastructure node setup

#### Create a new machineconfigpool infra
```
oc create -f infrastructure-machineconfigpool.yaml
```
#### Relabel worker machines as infra (3 are needed)
```
oc label node <NODE-NAME> node-role.kubernetes.io/infra=
```
```
oc label node <NODE-NAME> node-role.kubernetes.io/worker-
```
## Use the infra structure nodes

### Move the router bits

#### Move the internal routers to the infra nodes
```
oc patch ingresscontrollers.operator.openshift.io default -n openshift-ingress-operator --type=merge \
  --patch '{"spec":{"nodePlacement":{"nodeSelector":{"matchLabels":{"node-role.kubernetes.io/infra":""}}}}}'
```
#### Define 3 routers (default are 2!)
```
oc patch ingresscontrollers.operator.openshift.io default -n openshift-ingress-operator --type=merge \
  --patch '{"spec":{"replicas": 3}}'
```
### Move the registry bits

#### Move the [internal image registry](../internal-registry#internal-registry-setup) to the infra nodes
```
oc patch configs.imageregistry.operator.openshift.io cluster --type=merge \
  --patch '{"spec":{"nodeSelector":{"node-role.kubernetes.io/infra": ""}}}'
```
#### Move the [registry image pruner](../registry-image-pruner/README.md#registry-image-pruner-from-44) (from 4.4) to the infra nodes
```
oc patch imagepruners.imageregistry.operator.openshift.io cluster --type=merge \
  --patch '{"spec":{"nodeSelector": {"node-role.kubernetes.io/infra": ""}}}'
```
### Move the logging bits
#### Move the Kibana pod to the infras
```
oc patch clusterloggings.logging.openshift.io instance -n openshift-logging --type=merge \
  --patch '{"spec":{"visualization":{"kibana":{"nodeSelector":{"node-role.kubernetes.io/infra":""}}}}}'
```
#### Move the curator pod to the infras
```
oc patch clusterloggings.logging.openshift.io instance -n openshift-logging --type=merge \
  --patch '{"spec":{"curation":{"curator":{"nodeSelector":{"node-role.kubernetes.io/infra":""}}}}}'
```
#### Move the elasticsearch pods to the infras
```
oc patch clusterloggings.logging.openshift.io instance -n openshift-logging --type=merge \
  --patch '{"spec":{"logStore":{"elasticsearch":{"nodeSelector":{"node-role.kubernetes.io/infra":""}}}}}'
```
### Move the monitoring bits

> There's no chance to do that by an oc patch command!

Apply a new (modified) configmap that looks like [this](../logging-monitoring/custom-resource-definition-logging-on-infras.yaml)

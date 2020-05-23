# Infrastructure node setup

#### Create a new machineconfigpool infra
```
oc create -f infra-machineconfigpool.yaml
```
#### List the existing worker machineconfigs
```
oc get mc|grep worker|grep -v rendered|awk '{print $1}'
```
#### Get the the existing worker machineconfigs
```
oc get mc 00-worker -o yaml > 00-infra.yaml
```
```
oc get mc 01-worker-container-runtime -o yaml > 01-infra-container-runtime.yaml
```
```
oc get mc 01-worker-kubelet -o yaml > 01-infra-kubelet.yaml
```
```
oc get mc 99-worker-<HEX-VALUE-TO-REPLACE>-registries -o yaml > 99-infra-<HEX-VALUE-TO-REPLACE>-registries.yaml
```
```
oc get mc 99-worker-ssh -o yaml > 99-infra-ssh.yaml
```
#### Replace worker with infra and delete useless lines
```
sed -i \
-e '/annotations/,+1d' \
-e '/creationTimestamp/d' \
-e'/generation/d' \
-e '/ownerReference/,+6d' \
-e '/resourceVersion/d' \
-e '/selfLink/d' \
-e '/uid/ {/data/!d}' \
-e 's/worker/infra/' \
00-infra.yaml
```
```
sed -i \
-e '/annotations/,+1d' \
-e '/creationTimestamp/d' \
-e'/generation/d' \
-e '/ownerReference/,+6d' \
-e '/resourceVersion/d' \
-e '/selfLink/d' \
-e '/uid/ {/data/!d}' \
-e 's/worker/infra/' \
01-infra-container-runtime.yaml
```
```
sed -i \
-e '/annotations/,+1d' \
-e '/creationTimestamp/d' \
-e'/generation/d' \
-e '/ownerReference/,+6d' \
-e '/resourceVersion/d' \
-e '/selfLink/d' \
-e '/uid/ {/data/!d}' \
-e 's/worker/infra/' \
01-infra-kubelet.yaml
```
```
sed -i \
-e '/annotations/,+1d' \
-e '/creationTimestamp/d' \
-e'/generation/d' \
-e '/ownerReference/,+4d' \
-e '/resourceVersion/d' \
-e '/selfLink/d' \
-e '/uid/ {/data/!d}' \
-e 's/worker/infra/' \
99-infra-<HEX-VALUE-TO-REPLACE>-registries.yaml
```
```
sed -i \
-e '/annotations/,+1d' \
-e '/creationTimestamp/d' \
-e'/generation/d' \
-e '/ownerReference/,+6d' \
-e '/resourceVersion/d' \
-e '/selfLink/d' \
-e '/uid/ {/data/!d}' \
-e 's/worker/infra/' \
99-infra-ssh.yaml
```
#### Create the new infra machineconfigs
```
oc create -f 00-infra.yaml
```
```
oc create -f 01-infra-container-runtime.yaml
```
```
oc create -f 01-infra-kubelet.yaml
```
```
oc create -f 99-infra-<HEX-VALUE-TO-REPLACE>-registries.yaml
```
```
oc create -f 99-infra-ssh.yaml
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

Apply a new (modified) configmap that looks like [this](../logging/custom-resource-definition-logging-on-infras.yaml)

# Registry Image Pruner (from 4.4)

#### Unsuspend the registry image pruner
```
oc patch imagepruners.imageregistry.operator.openshift.io cluster --type=merge \
  --patch '{"spec":{"suspend": false}}'
```

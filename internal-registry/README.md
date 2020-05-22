# Internal registry setup

## Add ephemeral storage to the registry
```
# oc patch configs.imageregistry.operator.openshift.io cluster --type merge \
  --patch '{"spec":{"storage":{"emptyDir":{}}}}'
```

## Remove ephemeral storage from the registry

```
# oc patch configs.imageregistry.operator.openshift.io cluster --type json \
  --patch '[{ "op": "remove", "path": "/spec/storage" }]'
```

## Add pv storage to the registry

```
# oc patch configs.imageregistry.operator.openshift.io cluster --type merge \
  --patch '{"spec":{"storage":{"pvc":{"claim":""}}}}'
```

## Place the registry on the infrastructure nodes

```
# oc patch configs.imageregistry.operator.openshift.io/cluster --type=merge \
  --patch '{"spec":{"nodeSelector":{"node-role.kubernetes.io/infra": ""}}}'
```

## Set managementState to Managed (from 4.3)

```
# oc patch configs.imageregistry.operator.openshift.io cluster --type merge \
  --patch '{"spec":{"managementState":"Managed"}}'
```

# Expose the registry to have access from outside the cluster
## Expose the default route

```
# oc patch configs.imageregistry,operator.openshift.io/cluster --type=merge \
  --patch '{{"spec": {"defaultRoute": true}}'
```

# Manage the registry image pruner
## Unsuspend the registry image pruner (from 4.4)
```
# oc patch imagepruners.imageregistry.operator.openshift.io cluster --type=merge \
  --patch '{"spec":{"suspend": false}}'

```
## Set default schedule for the registry image pruner (from 4.4)
Just to see the default value in the config instead of an empty value!
The other default values like
- failedJobsHistoryLimit: 3
- keepTagRevisions: 3
- successfulJobsHistoryLimit: 3

are already set
```
# oc patch imagepruners.imageregistry.operator.openshift.io cluster --type=merge \
  --patch '{"spec":{"schedule": "*/0 * * * *"}}'
```

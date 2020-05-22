# Registry Image Pruner (from 4.4)

#### Unsuspend the registry image pruner
```
oc patch imagepruners.imageregistry.operator.openshift.io cluster --type=merge \
  --patch '{"spec":{"suspend": false}}'
```
#### Set default schedule for the registry image pruner (from 4.4)
Just to see the default value in the config instead of an empty value!
The other default values like
- failedJobsHistoryLimit: 3
- keepTagRevisions: 3
- successfulJobsHistoryLimit: 3

are already set

`The time zone is always Zulu time -> UTC`

```
# oc patch imagepruners.imageregistry.operator.openshift.io cluster --type=merge \
  --patch '{"spec":{"schedule": "0 0 * * *"}}'
```

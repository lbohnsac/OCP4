# Disabling Self-Provisioning


## Set autoupdate annotation to false
If autoupdate annotation is not updated upgrading the cluster or restarting cluster API restores default self-provisioner access.
```
# oc annotate clusterrolebinding self-provisioners rbac.authorization.kubernetes.io/autoupdate=false --overwrite
```
or
```
# oc patch clusterrolebinding.rbac self-provisioners --type=merge \
  --patch '{"metadata":{"annotations":{"rbac.authorization.kubernetes.io/autoupdate": "false"}}}'
```

## Remove cluster role self-provisioner from system group system:authenticated:oauth
```
# oc adm policy remove-cluster-role-from-group self-provisioner system:authenticated:oauth
```
If a user tries to create a project they will be greated with this default message: `You may not request a new project via this API`

## Customize the request message
To customize the request message set the projectRequestMessage in project.config.openshift.io cluster
```
# oc patch  project.config.openshift.io cluster --type=merge \
  --patch '{"spec":{"projectRequestMessage":"<YOUR CUSTOMIZED REQUEST MESSAGE>"}}'
```

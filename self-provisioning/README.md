# Disabling Self-Provisioning


##### Set autoupdate annotation to false

```
# oc annotate clusterrolebinding self-provisioners rbac.authorization.kubernetes.io/autoupdate=false --overwrite
```

##### Then remove cluster role self-provisioner from system group system:authenticated:oauth

```
# oc adm policy remove-cluster-role-from-group self-provisioner system:authenticated:oauth
```

If autoupdate annotation is not updated first, then restarting cluster API restores self-provisioner access

# Node maintenance

It will drains all the virtual machines and pods from it.

Virtual machine instances that have a LiveMigrate eviction strategy are live migrated to another node without loss of service.

Virtual machine instances without an eviction strategy will be deleted on the node and recreated on another node.

## Set a node to maintenance
To set a node in maintenance mode apply a NodeMaintenance Custom Resource object that references the node name and the reason for setting it to maintenance mode

Replace the values `<NODE_NAME>` and `<REASON>` in the maintenance.cr.yaml
```
# sed -i 's/<NODE_NAME>/<YOUR_NODE_NAME>; s/<REASON>/<YOUR_REASON_STRING/' maintenance.cr.yaml
```

Apply the the custom resource
```
# oc apply -f maintenance.cr.yaml
```

## Find a NodeMaintenance object
```
# oc get nodemaintenance
```

## Insepct a NodeMaintenance object
``` 
# oc describe nodemaintenance <MAINTENANCE-OBJECT>
```

## Resume a node from maintenance
```
# oc delete nodemaintenance <MAINTENANCE-OBJECT>
```

# NFS storage pv setup

## Registry volume

 #### Modify the following values
 
 < PATH TO THE PREDEFINED VOLUME >

< NFS SERVER FQDN >

in the registry.pv.yaml

## Create the registry pv
``` 
    # oc create -f registry.pv.yaml
```
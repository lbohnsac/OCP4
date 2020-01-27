# NFS storage pv setup

#### Prometheus volumes (2x)

##### Modify the following values

PATH TO THE PREDEFINED VOLUME

NFS SERVER FQDN

in the prometheus-{12}.pv.yaml

##### Create the prometheus pvs
    # oc apply -f prometheus-1.pv.yaml
    # oc apply -f prometheus-2.pv.yaml

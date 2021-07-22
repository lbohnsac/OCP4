# NFS storage pv setup

## Prometheus volumes (2x) using labels and claimRef
In OCP4.4 the names of the pvc have been changed! Use for clusters up to 4.3.x and from 4.5.x the files in the dir OCP4 and for 4.4.x clusters the files in the dir OCP4.4

#### Modify the following values

PATH TO THE PREDEFINED VOLUME

NFS SERVER FQDN

in the prometheus-[01].pv.yaml

#### Create the prometheus pvs
    # oc apply -f prometheus-0.pv.yaml
    # oc apply -f prometheus-1.pv.yaml

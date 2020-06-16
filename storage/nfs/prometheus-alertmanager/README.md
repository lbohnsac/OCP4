# NFS storage pv setup

#### Prometheus-Alertmanager volumes (3x)
In OCP4.4 the names of the pvc have been changed!
Use for clusters up to 4.3.x the files in the dir OCP4.3 and for clusters from 4.4.x the files in the dir OCP4.4

##### Modify the following values

PATH TO THE PREDEFINED VOLUME

NFS SERVER FQDN

in the prometheus-alertmanager[13].pv.yaml

##### Create the prometheus pvs
    # oc apply -f prometheus-alertmanager-0.pv.yaml
    # oc apply -f prometheus-alertmanager-2.pv.yaml
    # oc apply -f prometheus-alertmanager-2.pv.yaml

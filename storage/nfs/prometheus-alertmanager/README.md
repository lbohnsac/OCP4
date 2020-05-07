# NFS storage pv setup

#### Prometheus-Alertmanager volumes (3x)

##### Modify the following values

PATH TO THE PREDEFINED VOLUME

NFS SERVER FQDN

in the prometheus-alertmanager[13].pv.yaml

##### Create the prometheus pvs
    # oc apply -f prometheus-alertmanager-1.pv.yaml
    # oc apply -f prometheus-alertmanager-2.pv.yaml
    # oc apply -f prometheus-alertmanager-3.pv.yaml

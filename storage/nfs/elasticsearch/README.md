# NFS storage pv setup

## Elasticsearch volumes (3x)

#### Modify the following values

PATH TO THE PREDEFINED VOLUME

NFS SERVER FQDN

in the elasticsearch-[1..3].pv.yaml

#### Create the elasticsearch pvs
    # oc apply -f elasticsearch-1.pv.yaml
    # oc apply -f elasticsearch-2.pv.yaml
    # oc apply -f elasticsearch-3.pv.yaml

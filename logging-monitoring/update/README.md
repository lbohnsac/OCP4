# Update logging and monitoring

## Monitoring

Monitoring is updated with the OpenShift Cluster.

## Logging

Logging has been installed as a post-installation step to the OpenShift Cluster and must be updated separately.

### Health check

Check all Logging and ElasticSearch Pods are up and running and ElasticSearch status is 'green'.


### Prerequisites

* The Operators should have 'automatic' install plan approval, when following the steps.
* Otherwise, see product documentation.

* If using LocalStorage devices via LocalStorage-Operator for Monitoring and Logging, please update the LocalStorage Operator as well.


### Update ElasticSeach

Check available software-version of the operators

```shell
oc get packagemanifest elasticsearch-operator -n openshift-marketplace \
  -o go-template='{{range .status.channels}}{{.name}}{{"\n"}}{{end}}'
```

Patch the Operator subscription to use the target `<SOFTWARE-VERSION>` reported from the package manifests list.

```shell
# oc patch -n openshift-operators-redhat subscription elasticsearch-operator --type merge \
  --patch '{"spec":{"channel":"<SOFTWARE-VERSION>"}}'
```

e.g.

```shell
# oc patch -n openshift-operators-redhat subscription elasticsearch-operator --type merge \
  --patch '{"spec":{"channel":"4.5"}}'
```

Watch out for the operator to be successfully updated to the new version

```shell
oc get csvs -n openshift-operators-redhat
```

and for the ElasticSearch pods being rolled out with the new version

```shell
oc get pods -n openshift-logging
```

Check as well for ElasticSearch health

```shell
ESPODNAME=$(oc get pods -n openshift-logging --no-headers -l component=elasticsearch | head -1 | awk '{print $1}')
echo $ESPODNAME
oc exec -n openshift-logging -c elasticsearch $ESPODNAME -- es_cluster_health
```

> The update of the Operator and internal ElasticSearch activities after the update may take a couple of minutes.

Proceed with the next steps of updating the Logging operator once ElasticSearch update has fully completed and Elasticsearch is healthy.


### Update Logging Operator

Check available software-version of the operators

```shell
oc get packagemanifest cluster-logging -n openshift-marketplace \
  -o go-template='{{range .status.channels}}{{.name}}{{"\n"}}{{end}}'
```

Patch the Operator subscription to use the target `<SOFTWARE-VERSION>` reported from the package manifests list

```shell
# oc patch -n openshift-logging subscription cluster-logging --type merge \
  --patch '{"spec":{"channel":"<SOFTWARE-VERSION>"}}'
```

e.g.

```shell
# oc patch -n openshift-logging subscription cluster-logging --type merge \
  --patch '{"spec":{"channel":"4.5"}}'
```

Watch out for the operator to be successfully updated to the new version

```shell
oc get csvs -n openshift-logging
```

and for the Kibana and Fluentd pods being rolled out with the new version

```shell
oc get pods -n openshift-logging
```

Fluentd pods are rolled-out one after another on the different nodes, this may take a while.

Check for Logging CronJobs being created

```shell
oc get cj -n openshift-logging
```

Check as well for ElasticSearch indices (indices for 'app-000xx', 'infra-000xx' and 'audit-000xx' are created:

```shell
ESPODNAME=$(oc get pods -n openshift-logging --no-headers -l component=elasticsearch | head -1 | awk '{print $1}')
echo $ESPODNAME
oc exec -n openshift-logging -c elasticsearch $ESPODNAME -- indices
```

### Hints

The Logging update will update as well the installed CRD `instance` of `ClusterLogging`. Save the modified definition using

```shell
oc get clusterlogging instance -n openshift-logging -o yaml > custom-resource-definition-logging.applied.4.5-updated.yaml
```

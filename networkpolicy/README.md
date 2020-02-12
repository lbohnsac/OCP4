# Networkpolicies

To list networkpolicy objects run

```
# oc get netpol -n NAMESPACE
```

To edit networkpolicy objects run

```
# oc edit netpol NAME_OF POLICY -n NAMESPACE
```

If the default Ingress Controller configuration has the ``spec.endpointPublishingStrategy: HostNetwork`` value set, you must apply a label to the the default OpenShift Container Platform namespace to allow network traffic between the Ingress Controller and the project:

Determine if your default Ingress Controller uses the HostNetwork endpoint publishing strategy:

```
# oc get --namespace openshift-ingress-operator ingresscontrollers/default \
  --output jsonpath='{.status.endpointPublishingStrategy.type}'
```

If the previous command reports the endpoint publishing strategy as HostNetwork, set a label on the default namespace:

```
# oc label namespace default 'network.openshift.io/policy-group=ingress'
```

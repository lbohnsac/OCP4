## Managing OLM Operator Catalogs (CatalogSources)

By default OCP4 was shipped with 3 default Operator Catalogs
- redhat-operators
- certified-operators
- community-operators

and since OCP 4.5 with one more
- marketplace-operators

##### List all configured CatalogSources

```
# oc get catalogsources.operators.coreos.com  -n openshift-marketplace
NAME                  DISPLAY               TYPE   PUBLISHER   AGE
certified-operators   Certified Operators   grpc   Red Hat     45m
community-operators   Community Operators   grpc   Red Hat     45m
redhat-marketplace    Red Hat Marketplace   grpc   Red Hat     45m
redhat-operators      Red Hat Operators     grpc   Red Hat     45m
```

> On the WebUi these Operator Catalogs are shown as `Provider Types` on the OperatorHub page on the Administrator Console

##### Disable only one specific CatalogSource (e.g. community-operators)

```
# oc patch operatorhubs.config.openshift.io cluster --type merge \
  --patch '{"spec":{"sources":[{"disabled": true,"name": "community-operators"}]}}'
```

or

```
# oc patch operatorhubs.config.openshift.io cluster --type json \
  --patch '[{"op": "add","path": "/spec/sources","value": [{"disabled": true,"name": "community-operators"}]}]'
```

##### Disable two specific CatalogSources (e.g. community-operators and certified-operators)

```
# oc patch operatorhubs.config.openshift.io cluster --type merge \
  --patch '{"spec":{"sources":[{"disabled": true,"name": "certified-operators"},\
  {"disabled": true,"name": "community-operators"}]}}'
```

or

```
# oc patch operatorhubs.config.openshift.io cluster --type json \
  --patch '[{"op": "add","path": "/spec/sources","value": [{"disabled": true,"name": "community-operators"},\
  {"disabled": true,"name": "certified-operators"}]}]'
```

##### Disable all default CatalogSources (needed for a disconnected environment)

```
# oc patch operatorhub.config.openshift.io cluster --type=merge \
  --patch '{"spec":{"disableAllDefaultSources":true}}'
```

or

```
# oc patch operatorhub.config.openshift.io cluster --type json \
  --patch '[{"op": "add", "path": "/spec/disableAllDefaultSources", "value": true}]'
```

##### Enable all default CatalogSources again

```
# oc patch operatorhub.config.openshift.io/cluster --type=merge \
  --patch '{"spec":{"disableAllDefaultSources":false}}'
```

or

```
# oc patch operatorhubs.config.openshift.io cluster --type json \
  --patch '[{ "op": "remove", "path": "/spec/disableAllDefaultSources" }]'
```

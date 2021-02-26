# Update local-storage-operator

#### Get the current version of the operator

```shell
oc get csv -n local-storage
```

#### Check available software-version of the operators

```shell
oc get packagemanifest local-storage-operator -n openshift-marketplace \
  --template='{{range .status.channels}}{{.name}}{{"\n"}}{{end}}'
```

#### Patch the Operator subscription to use the target `<SOFTWARE-VERSION>` reported from the package manifests list

```shell
oc patch local-storage subscription local-storage-operator --type merge \
  --patch '{"spec":{"channel":"<SOFTWARE-VERSION>"}}'
```

e.g.

```shell
oc patch -n local-storage subscription local-storage-operator --type merge --patch '{"spec":{"channel":"4.7"}}' \
  --patch '{"spec":{"channel":"4.7"}}'
```

#### Watch out for the operator to be successfully updated to the new version

```shell
watch -n 1 -d oc get csvs -n local-storage
```

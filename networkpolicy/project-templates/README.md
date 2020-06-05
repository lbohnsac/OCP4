# Use a customised default project template

##### Standard project template with neworkpolicies for "multitenancy"

Replace CLUSTERNAME in the file project-request-template.yaml
```
sed -i 's/<CLUSTERNAME>/<YOUR_VALUE>/' project-request-template.yaml
```
And apply it
```
oc apply -f project-request-template.yaml -n openshift-config
```

Set up the created template as default template for new projects
```
oc patch project.config.openshift.io/cluster --type=merge \
  --patch '{"spec": {"projectRequestTemplate": {"name": "<YOUR_TEMPLATE_NAME>"}}}'
```
Add the template request message
```
oc patch project.config.openshift.io/cluster --type=merge \
  --patch '{"spec": {"projectRequestMessage":"Message for you users"}}'
```

To modify it manually run
```
oc edit project.config.openshift.io/cluster
```

# Install keepalived-operator

### Configure the external ips to use

#### check the current status
```
oc get network cluster --template='{{range .spec.externalIP}}{{.policy}}{{"\n"}}{{end}}'
```

#### Add a network range for allowedCIDRs

e.g 192.168.123.0/24

```
oc patch network cluster --type merge \
  --patch '{"spec":{"externalIP":{"policy":{"allowedCIDRs":["192.168.123.0/24"]}}}}'
```
or more than on entry

e.g. the range from 192.168.123.4 to 192.168.123.9

```
oc patch network cluster --type merge \
  --patch '{"spec":{"externalIP":{"policy":{"allowedCIDRs":["192.168.123.4/30","192.168.124.8/31"]}}}}'
```

#### Watch the pods being rolled out
```
watch oc get pods -n openshift-kube-apiserver
```
this will take several minutes... be patient

### Install the operator

#### Create the subscripton

```
oc create -f subscription-operator-keepalived.yaml
```

### Configure the operator

#### Create the project keepalived-operator

```
oc create -f project-keepalived-operator.ymal
```

#### Add the privileged scc

```
oc adm policy add-scc-to-user privileged -z default -n keepalived-operator
```

#### Check if there are already active keepalived on the network

```
tcpdump -i <NETWORK_INTERFACE> | grep -i vrrp
```

#### Create the KeepalivedGroup

```
oc create -f keepalivedgroup-infra.yaml
```

#### Watch the daemonset pods beeing rolled out
```
watch oc get pods -n keepalived-operator
```

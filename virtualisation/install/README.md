# Install Openshift Virtualization (new since 4.5)

#### Create the namespace openshift-cnv
```
# oc create -f namespace-cnv.yaml
```

#### Create the operatorgroup
```
# oc create -f operatorgrup-cnv.yaml
```

#### Create the subscription

##### For Openshift 4.5
```
# oc create -f OCP4.5/operator-subscription-kubevirt-hyperconverged-2.4.yaml
```

##### For Openshift 4.6
```
# oc create -f OCP4.6/operator-subscription-kubevirt-hyperconverged-2.5.yaml
```

##### For Openshift 4.7
```
# oc create -f OCP4.7/operator-subscription-kubevirt-hyperconverged-2.6.yaml
```

#### Deploy the Openshift Virtualization Operator

##### For Openshift 4.5
```
# oc create -f OCP4.5/hyperconverged-2.4.yaml
```

##### For Openshift 4.6
```
# oc create -f OCP4.6/hyperconverged-2.5.yaml
```

##### For Openshift 4.7
```
# oc create -f OCP4.7/hyperconverged-2.5.yaml
```

#### Check the installation
```
# watch oc get csv -n openshift-cnv
```

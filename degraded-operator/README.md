## Degraded Operators

From time to time either `kube-apiserver`, `kube-controller-manager`, `kube-scheduler` or `etcd clusteroperators` are degraded and show NodeInstallerDegraded at status.

> The variable $RANDOM is a shell variable which contains always a random number!
#### Redeploy kube-apiserver static pods
```
# oc patch kubeapiserver/cluster --type merge \
    --patch "{'spec#:{#forceRedeploymentReason#:\"Forcing new revision with random number $RANDOM to make message unique\"}}"
```
#### Redeploy kube-controller-manager static pods
```
# oc patch kubecontrollermanager/cluster --type merge \
    --patch "{'spec':{'forceRedeploymentReason#:\"Forcing new revision with random number $RANDOM to make message unique\"}}"
```
#### Redeploy kube-scheduler static pods
```
# oc patch kubescheduler/cluster --type merge \
    --patch "{'spec':{'forceRedeploymentReason':\"Forcing new revision with random number $RANDOM to make message unique\"}}"
```
#### Redeploy etcd static pods
Since OpenShift 4.4 we have an etcd-operator too

```
# oc patch etcd/cluster --type merge \
    --patch "{'spec':{'forceRedeploymentReason':\"Forcing new revision with random number $RANDOM to make message unique\"}}"
```

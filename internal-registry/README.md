# Internal registry setup

##### Add ephemeral storage to the registry
    # oc patch configs.imageregistry.operator.openshift.io cluster --type merge --patch '{"spec":{"storage":{"emptyDir":{}}}}'

##### Remove ephemeral storage from the registry
    # oc patch configs.imageregistry.operator.openshift.io cluster --type json --patch '[{ "op": "remove", "path": "/spec/storage" }]'

##### Add pv storage to the registry
    # oc patch configs.imageregistry.operator.openshift.io cluster --type merge --patch '{"spec":{"storage":{"pvc":{"claim":""}}}}'

##### Place the registry on the infrastructure nodes
    # oc patch configs.imageregistry.operator.openshift.io/cluster --type=merge -p '{"spec":{"nodeSelector":{"node-role.kubernetes.io/infra": ""}}}'

# Templates to use

##### Standard project template with neworkpolicies for "multitenancy"

Replace <CLUSTERNAME> and
    
    # oc apply -f project-request-template.yaml -n openshift-config

Set up the created template as deafult template for new projects

    # oc edit project.config.openshift.io/cluster 

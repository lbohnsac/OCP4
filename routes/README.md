# Routes

##### Create a secured edge termination route from cli
    # oc create route edge <ROUTENAME> --service=<SERVICENAME>
    
##### Create an unsecured http route from cli
    # oc expose service <SERVICENAME>

##### Change a http route to https with edge termination
    # oc patch <ROUTENAME> --type=merge -p '{"spec":{"tls":{"termination": "edge"}}}'
    
##### Change a https route to http
    # oc patch <ROUTENAME> --type json --patch '[{ "op": "remove", "path": "/spec/tls" }]'

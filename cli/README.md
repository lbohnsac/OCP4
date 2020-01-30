# Download and install Openshift 4.x CLI

    ### Set OpenShift Version
    VERSION=4.x.x #changeme

    wget https://mirror.openshift.com/pub/openshift-v4/clients/ocp/$VERSION/openshift-client-linux-$VERSION.tar.gz
    tar -xf openshift-client-linux-$VERSION.tar.gz
    sudo cp -v {oc,kubectl} /usr/bin/
    rm -Rf openshift-install-linux-$VERSION.tar.gz
    rm -Rf oc
    rm -Rf kubectl
    oc version
    kubectl version

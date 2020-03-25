# Download and install OpenShift4 Installer

##### Check here which versions are available

    # curl -s https://mirror.openshift.com/pub/openshift-v4/clients/ocp/ |awk '{print $5}'|grep -o '4.[0-9].[0-9]*'

##### Set variable VERSION to the choosen version

    ### Set OpenShift Version
    VERSION=4.x.x #changeme

    # wget https://mirror.openshift.com/pub/openshift-v4/clients/ocp/$VERSION/openshift-install-linux-$VERSION.tar.gz
    # tar -xvf openshift-install-linux-$VERSION.tar.gz
    # sudo cp -v openshift-install /usr/bin/
    # rm -Rf openshift-install-linux-$VERSION.tar.gz
    # rm -Rf openshift-install

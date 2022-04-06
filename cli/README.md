# Download and install Openshift 4.x CLI

##### Check here which versions are available

```
# curl -s https://mirror.openshift.com/pub/openshift-v4/clients/ocp/ | \
  grep '<span class="name">' | \
  grep -o '\<4.[0-9]*.[0-9]*.[0-9]*\>' | \
  sort -uV | \
  column
```

##### To download and install the oc client set variable VERSION to the choosen version

```
### Set OpenShift Version
VERSION=4.x.x #change me

wget https://mirror.openshift.com/pub/openshift-v4/clients/ocp/$VERSION/openshift-client-linux-$VERSION.tar.gz
tar -xf openshift-client-linux-$VERSION.tar.gz
sudo cp -v {oc,kubectl} /usr/bin/
rm -Rf openshift-client-linux-$VERSION.tar.gz
rm -Rf oc
rm -Rf kubectl
oc version
kubectl version
```

##### To download and install the oc installer set variable VERSION to the choosen version

```
### Set OpenShift Version
VERSION=4.x.x #change me

wget https://mirror.openshift.com/pub/openshift-v4/clients/ocp/$VERSION/openshift-install-linux-$VERSION.tar.gz
tar -xf openshift-install-linux-$VERSION.tar.gz
sudo cp -v openshift-install /usr/bin/
rm -Rf openshift-install-linux-$VERSION.tar.gz
rm -Rf openshift-install
openshift-install version
```

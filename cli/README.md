# Download and install Openshift 4.x CLI

#### Check here which versions are available

```
# curl -s https://mirror.openshift.com/pub/openshift-v4/clients/ocp/ | \
  awk '{print $5}' | \
  grep -v latest | \
  grep -v Parent | \
  grep -o '4.[0-9]*.[0-9]*' | \
  uniq | \
  sort | \
  column
```

#### Set variable VERSION to the choosen version

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

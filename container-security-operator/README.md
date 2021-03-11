# Install the container-security-operator (new since 4.6)

You don't have to create a project or an operator group, because the container-security-operator installs itself in the openshift-operators project and also uses the OG global-operators that already exist there.`

#### Change into the project openshift-operators
```
oc project openshift-operators
```

#### Check which software version of the operactor is available
```
oc get packagemanifest container-security-operator -n openshift-marketplace \
  --template='{{range .status.channels}}{{.name}}{{"\n"}}{{end}}'
  ```
###### Modify the following value
  SOFTWARE-VERSION

  in subscription-container-security.yaml

  Pick the version you want to install
  ```
  sed -i 's/<SOFTWARE-VERSION>/<VERSION YOU PICKED>/' subscription-container-security.yaml
  ```
#### Create the subscription
  ```
  oc create -f subscription-container-security.yaml
  ```

#### Watch the installation
  ```
  watch -n 1 -d oc get csvs -n oc get csvs -n openshift-operators
  ```

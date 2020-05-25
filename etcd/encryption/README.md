# ETCD encryption

#### Encrypt etcd data
Modify the API server object and set the encryption field type to `aescbc`
```
oc patch apiservers.config.openshift.io cluster --type=merge \
  --patch '{"spec": {"encryption": {"type": "aescbc"}}}'
```
The encryption will start and it will take a while ... wait until the encryption process is completed.
#### Check the encryption status
Review the encrypted status condition for the OpenShift API server to verify that its resources were successfully encrypted.
```
oc get openshiftapiserver \
  -o=jsonpath='{range .items[0].status.conditions[?(@.type=="Encrypted")]}{.reason}{"\n"}{.message}{"\n"}'
```
It's done when you get the following output:
```
EncryptionCompleted
All resources encrypted: routes.route.openshift.io, oauthaccesstokens.oauth.openshift.io, oauthauthorizetokens.oauth.openshift.io
```
Review the Encrypted status condition for the Kubernetes API server to verify that its resources were successfully encrypted.
```
oc get kubeapiserver \
  -o=jsonpath='{range .items[0].status.conditions[?(@.type=="Encrypted")]}{.reason}{"\n"}{.message}{"\n"}'
```
It's done when you get the following output:
```
EncryptionCompleted
All resources encrypted: secrets, configmaps
```

#### Decrypt etcd data
Modify the API server object and set the encryption field type to `identity`
```
oc patch apiservers.config.openshift.io cluster --type=merge \
  --patch '{"spec": {"encryption": {"type": "identity"}}}'
```
#### Check the decryptipon status
Review the Decrypted status condition for the OpenShift API server to verify that its resources were successfully decrypted
```
oc get openshiftapiserver /
  -o=jsonpath='{range .items[0].status.conditions[?(@.type=="Encrypted")]}{.reason}{"\n"}{.message}{"\n"}'
```
It's done when you get the following output:
```
DecryptionCompleted
Encryption mode set to identity and everything is decrypted
```
Review the Encrypted status condition for the Kubernetes API server to verify that its resources were successfully encrypted
```
oc get kubeapiserver \
  -o=jsonpath='{range .items[0].status.conditions[?(@.type=="Encrypted")]}{.reason}{"\n"}{.message}{"\n"}'
```
It's done when you get the following output:
```
DecryptionCompleted
Encryption mode set to identity and everything is decrypted
```

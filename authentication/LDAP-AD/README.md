# LDAP-AD authentication

##### Define an OpenShift Container Platform Secret that contains the bindPassword.

```
# oc create secret generic ldap-secret --from-literal=bindPassword=<password> -n openshift-config
```

##### Create a ConfigMap that contains the TLS certificate of the LDAP server
If possible, you must obtain the certificate authority (CA) certificate used to sign the AD server certificate. Ask your AD administrator to provide this for you in PEM format. If this isn’t possible and if you are reasonably sure your network connection isn’t compromised, you can use openssl to retrieve the server certificate from the server. The following example demonstrates how to do this.

```
# openssl s_client -connect ldap.domain.tld:636 -showcerts < /dev/null
```
Identity providers use OpenShift Container Platform ConfigMaps in the openshift-config namespace to contain the certificate authority bundle. These are primarily used to contain certificate bundles needed by the identity provider.
Define an OpenShift Container Platform ConfigMap containing the certificate authority by using the following command. The certificate authority must be stored in the ca.crt key of the ConfigMap.

```
# oc create configmap ca-config-map --from-file=ca.crt=/path/to/ca -n openshift-config
```

##### Modify the ldap-ad.cr.yaml with the correct values

BINDUSER
:
AD-SERVER-FQDN

PATH-TO-GROUP

:1.2.840.113556.1.4.1941: is needed if you have to search a nested group! (https://ldapwiki.com/wiki/LDAP_MATCHING_RULE_IN_CHAIN)

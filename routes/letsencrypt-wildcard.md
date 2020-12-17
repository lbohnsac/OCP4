# Let's encrypt wild card certificate

## Manual deployment by using external DNS

Given are the following values
- EMAIL          e.g. user@example.com
- WILDCARD       e.g. *.apps.ocp.example.com
- external DNS without direct access (therefore we have to do it in the manual way)

#### Clone the git repo `github.com/certbot`
```
# git clone https://github.com/certbot/certbot.git
Cloning into 'certbot'...
remote: Enumerating objects: 87, done.
remote: Counting objects: 100% (87/87), done.
remote: Compressing objects: 100% (73/73), done.
remote: Total 85454 (delta 38), reused 35 (delta 14), pack-reused 85367
Receiving objects: 100% (85454/85454), 43.37 MiB | 16.62 MiB/s, done.
Resolving deltas: 100% (62586/62586), done.

```

#### Change into the dir `certbot`
```
# cd certbot
```

#### Get the wild card certificate and the key
> By default it will be a 2048 bit RSA key
>
> To generate a 4096 RSA key add `--rsa-key-size 4096` option
>
> To generate a ECDSA key add `--key-type ecdsa` option to the command below
>
> It's either RSA key or ECDSA key, not both!
>
> Take care older TLS clients are not able to handel ECDSA keys (current browsers will do)

```
./certbot-auto certonly \
    --manual \
    --preferred-challenges=dns \
    --email=user@example.com \
    --server=https://acme-v02.api.letsencrypt.org/directory \
    --agree-tos \
    -d *.apps.ocp.example.com
Saving debug log to /var/log/letsencrypt/letsencrypt.log
Plugins selected: Authenticator manual, Installer None
Requesting a certificate for *.apps.ocp.example.com
Performing the following challenges:
dns-01 challenge for apps.ocp.example.com

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Please deploy a DNS TXT record under the name
_acme-challenge.apps.ocp.example.com with the following value:

ye7kl-VjACJB7EJbdU72uZ5PZTGw0AGGqs3GmoZm-Is

Before continuing, verify the record is deployed.
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Press Enter to Continue
```

#### Deploy on the external DNS the given configuration

#### Check the DNS entry
```
# dig -t txt _acme-challenge.apps.ocp.example.com

; <<>> DiG 9.11.4-P2-RedHat-9.11.4-26.P2.el7 <<>> -t txt _acme-challenge.apps.ocp.example.com
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 37713
;; flags: qr rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 512
;; QUESTION SECTION:
;_acme-challenge.apps.ocp.example.com. IN TXT

;; ANSWER SECTION:
_acme-challenge.apps.ocp.example.com. 3600 IN TXT "ye7kl-VjACJB7EJbdU72uZ5PZTGw0AGGqs3GmoZm-Is"

;; Query time: 76 msec
;; SERVER: 127.0.0.1#53(127.0.0.1)
;; WHEN: Do Dez 17 11:57:42 CET 2020
;; MSG SIZE  rcvd: 124
```

#### If the DNS entry is correct press ENTER
```
Waiting for verification...
Cleaning up challenges

IMPORTANT NOTES:
 - Congratulations! Your certificate and chain have been saved at:
   /etc/letsencrypt/live/apps.ocp.example.com/fullchain.pem
   Your key file has been saved at:
   /etc/letsencrypt/live/apps.ocp.example.com/privkey.pem
   Your cert will expire on 2021-03-17. To obtain a new or tweaked
   version of this certificate in the future, simply run certbot-auto
   again. To non-interactively renew *all* of your certificates, run
   "certbot-auto renew"
 - If you like Certbot, please consider supporting our work by:

   Donating to ISRG / Let's Encrypt:   https://letsencrypt.org/donate
   Donating to EFF:                    https://eff.org/donate-le
```

#### Check the new directory structure `/etc/letsencrypt`
```
# tree /etc/letsencrypt/
/etc/letsencrypt/
├── accounts
│   └── acme-v02.api.letsencrypt.org
│       └── directory
│           └── 56b952b7ee215b9e1e76567b2e4860aa
│               ├── meta.json
│               ├── private_key.json
│               └── regr.json
├── archive
│   └── apps.ocp.example.com
│       ├── cert1.pem
│       ├── chain1.pem
│       ├── fullchain1.pem
│       └── privkey1.pem
├── csr
│   ├── 0000_csr-certbot.pem
│   └── 0001_csr-certbot.pem
├── keys
│   ├── 0000_key-certbot.pem
│   └── 0001_key-certbot.pem
├── live
│   ├── apps.ocp.example.com
│   │   ├── cert.pem -> ../../archive/apps.ocp.example.com/cert1.pem
│   │   ├── chain.pem -> ../../archive/apps.ocp.example.com/chain1.pem
│   │   ├── fullchain.pem -> ../../archive/apps.ocp.example.com/fullchain1.pem
│   │   ├── privkey.pem -> ../../archive/apps.ocp.example.com/privkey1.pem
│   │   └── README
│   └── README
├── renewal
│   └── apps.ocp.example.com.conf
└── renewal-hooks
    ├── deploy
    ├── post
    └── pre
```

#### Verify the new let's encrypt certificate
```
# ./certbot-auto certificates
Saving debug log to /var/log/letsencrypt/letsencrypt.log

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Found the following certs:
  Certificate Name: apps.ocp.example.com
    Serial Number: 487f4c3097de76a3b53260fda781e5d38dd
    Key Type: RSA
    Domains: *.apps.ocp.example.com
    Expiry Date: 2021-03-17 09:57:54+00:00 (VALID: 89 days)
    Certificate Path: /etc/letsencrypt/live/apps.ocp.example.com/fullchain.pem
    Private Key Path: /etc/letsencrypt/live/apps.ocp.example.com/privkey.pem
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
```

#### Create a new secret with the let's encrypt fullchain.pem
```
# oc create secret tls letsencrypt-wildcard-router-certs \
    --cert=/etc/letsencrypt/live/apps.ocp.example.com/fullchain.pem \
    --key=/etc/letsencrypt/live/apps.ocp.example.com/privkey.pem \
    -n openshift-ingress
secret/letsencrypt-wildcard-router-certs created
```

#### Change the default certificate used by the ingresscontroller
```
# oc patch ingresscontroller default \
    -n openshift-ingress-operator \
    --type=merge \
    --patch='{"spec": { "defaultCertificate": { "name": "letsencrypt-wildcard-router-certs" }}}'
ingresscontroller.operator.openshift.io/default patched
```

#### The routers are automatically redeployed
```
# oc get pod -n openshift-ingress
NAME                              READY   STATUS        RESTARTS   AGE
router-default-5845b86bf8-d2khd   0/1     Pending       0          28s
router-default-c67f4f86c-bttzg    1/1     Running       0          5d23h
router-default-c67f4f86c-jp6f7    0/1     Terminating   0          5d22h
router-default-c67f4f86c-kf9pn    1/1     Running       0          5d22h
```

#### Replace a RSA key with an ECDSA key for an current cert

>
> Choose option 2 Renew & replace the cert (may be subject to CA rate limits) this stime
>

```
# ./certbot-auto certonly \
      --key-type ecdsa \
      --manual \
      --preferred-challenges=dns \
      --email=user@example.com \
      --server=https://acme-v02.api.letsencrypt.org/directory \
      --agree-tos \
      -d *.apps.ocp.example.com 
      --cert-name apps.ocp.example.com
Saving debug log to /var/log/letsencrypt/letsencrypt.log
Plugins selected: Authenticator manual, Installer None
Cert not yet due for renewal

You have an existing certificate that has exactly the same domains or certificate name you requested and isn't close to expiry.
(ref: /etc/letsencrypt/renewal/apps.ocp.example.com.conf)

What would you like to do?
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
1: Keep the existing certificate for now
2: Renew & replace the cert (may be subject to CA rate limits)
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Select the appropriate number [1-2] then [enter] (press 'c' to cancel): 2
Renewing an existing certificate for *.apps.ocp.example.com

IMPORTANT NOTES:
 - Congratulations! Your certificate and chain have been saved at:
   /etc/letsencrypt/live/apps.ocp.example.com/fullchain.pem
   Your key file has been saved at:
   /etc/letsencrypt/live/apps.ocp.example.com/privkey.pem
   Your cert will expire on 2021-03-17. To obtain a new or tweaked
   version of this certificate in the future, simply run certbot-auto
   again. To non-interactively renew *all* of your certificates, run
   "certbot-auto renew"
 - If you like Certbot, please consider supporting our work by:

   Donating to ISRG / Let's Encrypt:   https://letsencrypt.org/donate
   Donating to EFF:                    https://eff.org/donate-le
```

#### Verify the new let's encrypt certificate
```
# ./certbot-auto certificates
Saving debug log to /var/log/letsencrypt/letsencrypt.log

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Found the following certs:
  Certificate Name: apps.ocp.example.com
    Serial Number: 489c2875e490d1eb4cd88faf2323c4b414a
    Key Type: ECDSA
    Domains: *.apps.ocp.example.com
    Expiry Date: 2021-03-17 14:10:08+00:00 (VALID: 89 days)
    Certificate Path: /etc/letsencrypt/live/apps.ocp.example.com/fullchain.pem
    Private Key Path: /etc/letsencrypt/live/apps.ocp.example.com/privkey.pem
```

#### Replace the default certificate of the ingress controller with the new certificate
First we have to delete the current secret
```
# oc delete secret letsencrypt-wildcard-router-certs -n openshift-ingress
secret "letsencrypt-wildcard-router-certs" deleted
```

Create a new one with the same name and the new certificate and key
```
# oc create secret tls letsencrypt-wildcard-router-certs \
    --cert=/etc/letsencrypt/live/apps.ocp.example.com/fullchain.pem \
    --key=/etc/letsencrypt/live/apps.ocp.example.com/privkey.pem 
    -n openshift-ingress
secret/letsencrypt-wildcard-router-certs created
```

And delete the router pods so they will recreated with the new secret
```
# oc delete po -n openshift-ingress --all
pod "router-default-5845b86bf8-d2khd" deleted
pod "router-default-c67f4f86c-bttzg" deleted
pod "router-default-5845b86bf8-wqmqq" deleted
```

>
> Unfortunately there's no renew or auto-renew option for manual deployment!
> 
> We have to apply for a new certificate like we just did, delete the secret, recreate the secret and delete the router pods.
>
> Only the dns setup is not necessary as long as we do not change the domain name or the account
>

#### Revoking the certificate

Options for the reason are
- unspecified
- keycompromise
- affiliationchanged
- superseded
- cessationofoperation

>
> Choose Y to delete
>
> If you choosed N we have to delete the certs manually with
>
> ./certbot-auto delete --cert-name apps.ocp.example.com
>

```
# ./certbot-auto revoke \
    --cert-path /etc/letsencrypt/live/apps.ocp.example.com/cert.pem \
    --reason keycompromise
Saving debug log to /var/log/letsencrypt/letsencrypt.log

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Would you like to delete the cert(s) you just revoked, along with all earlier
and later versions of the cert?
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
(Y)es (recommended)/(N)o: Y
Congratulations! You have successfully revoked the certificate that was located at /etc/letsencrypt/live/apps.ocp.example.com/cert.pem.
```

#### After the successful revoke get a new certificate in same way we did in the beginning

>
> We have to apply for a new certificate like we did, delete the secret, recreate the secret and delete the router pods.
>
> Only the dns setup is not necessary as long as we do not change the domain name or the account

# KREW

##### Installing KREW

```
# (
  set -x; cd "$(mktemp -d)" &&
  curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/krew.{tar.gz,yaml}" &&
  tar zxvf krew.tar.gz &&
  KREW=./krew-"$(uname | tr '[:upper:]' '[:lower:]')_amd64" &&
  "$KREW" install --manifest=krew.yaml --archive=krew.tar.gz &&
  "$KREW" update
)
```

```
# export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
```

##### Update KREW plugins

```
# oc krew update
```

##### Search KREW plugins

```
# oc krew search
NAME                            DESCRIPTION                                         INSTALLED
access-matrix                   Show an RBAC access matrix for server resources     no
advise-psp                      Suggests PodSecurityPolicies for cluster.           no
auth-proxy                      Authentication proxy to a pod or service            no
[...]
```

##### Install a KREW plugin

```
oc krew install access-matrix
```

##### Uninstall a KREW plugin

```
oc krew uninstall access-matrix
```

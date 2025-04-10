# KREW

##### Installing KREW

```
# (
  set -x; cd "$(mktemp -d)" &&
  OS="$(uname | tr '[:upper:]' '[:lower:]')" &&
  ARCH="$(uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$/arm64/')" &&
  KREW="krew-${OS}_${ARCH}" &&
  curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/${KREW}.tar.gz" &&
  tar zxvf "${KREW}.tar.gz" &&
  ./"${KREW}" install krew
)
```
Set in your .bashrc
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

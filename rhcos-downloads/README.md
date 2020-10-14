# RHCOS (Red Hat Core OS) image download URLs

## Installer kernel
#### OCP 4.3.0
```
# wget https://mirror.openshift.com/pub/openshift-v4/dependencies/rhcos/4.3/4.3.0/rhcos-4.3.0-x86_64-installer-kernel
```
#### OCP 4.3.8
```
# wget https://mirror.openshift.com/pub/openshift-v4/dependencies/rhcos/4.3/4.3.8/rhcos-4.3.8-x86_64-installer-kernel-x86_64
```
#### OCP 4.4.3
```
# wget https://mirror.openshift.com/pub/openshift-v4/dependencies/rhcos/4.4/4.4.3/rhcos-4.4.3-x86_64-installer-kernel-x86_64
```
#### OCP 4.5.2
```
# wget https://mirror.openshift.com/pub/openshift-v4/dependencies/rhcos/4.5/4.5.2/rhcos-4.5.2-x86_64-installer-kernel-x86_64
```

#### OCP 4.5.6
```
# wget https://mirror.openshift.com/pub/openshift-v4/dependencies/rhcos/4.5/4.5.6/rhcos-4.5.6-x86_64-installer-kernel-x86_64
```

## Installer initramfs
#### OCP 4.3.0
```
# wget https://mirror.openshift.com/pub/openshift-v4/dependencies/rhcos/4.3/4.3.0/rhcos-4.3.0-x86_64-installer-initramfs.img
```
#### OCP 4.3.8
```
# wget https://mirror.openshift.com/pub/openshift-v4/dependencies/rhcos/4.3/4.3.8/rhcos-4.3.8-x86_64-installer-initramfs.x86_64.img
```
#### OCP 4.4.3
```
# wget https://mirror.openshift.com/pub/openshift-v4/dependencies/rhcos/4.4/4.4.3/rhcos-4.4.3-x86_64-installer-initramfs.x86_64.img
```
#### OCP 4.5.2
```
# wget https://mirror.openshift.com/pub/openshift-v4/dependencies/rhcos/4.5/4.5.2/rhcos-4.5.2-x86_64-installer-initramfs.x86_64.img
```

#### OCP 4.5.6
```
# wget https://mirror.openshift.com/pub/openshift-v4/dependencies/rhcos/4.5/4.5.6/rhcos-4.5.6-x86_64-installer-initramfs.x86_64.img
```

## RHCOS metal BIOS image
#### OCP 4.3.0
```
# wget https://mirror.openshift.com/pub/openshift-v4/dependencies/rhcos/4.3/4.3.0/rhcos-4.3.0-x86_64-metal.raw.gz
```
#### OCP 4.3.8
```
# wget https://mirror.openshift.com/pub/openshift-v4/dependencies/rhcos/4.3/4.3.8/rhcos-4.3.8-x86_64-metal.x86_64.raw.gz
```
#### OCP 4.4.3
```
# wget https://mirror.openshift.com/pub/openshift-v4/dependencies/rhcos/4.4/4.4.3/rhcos-4.4.3-x86_64-metal.x86_64.raw.gz
```
#### OCP 4.5.2
```
# wget https://mirror.openshift.com/pub/openshift-v4/dependencies/rhcos/4.5/4.5.2/rhcos-metal.x86_64.raw.gz
```
#### OCP 4.5.6
```
# wget https://mirror.openshift.com/pub/openshift-v4/dependencies/rhcos/4.5/4.5.6/rhcos-metal.x86_64.raw.gz
```

## Always run restorecon after you placed the downloaded files

```
# restorecon -RFv <PATH TO THE LOCATION>
```

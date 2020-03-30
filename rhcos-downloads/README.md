# RHCOS (Red Hat Core OS) image download URLs

##### Installer kernel
```
# wget https://mirror.openshift.com/pub/openshift-v4/dependencies/rhcos/4.3/4.3.0/rhcos-4.3.0-x86_64-installer-kernel
# wget https://mirror.openshift.com/pub/openshift-v4/dependencies/rhcos/4.3/4.3.8/rhcos-4.3.8-x86_64-installer-kernel-x86_64# wget
```

##### Installer initramfs

```
# wget https://mirror.openshift.com/pub/openshift-v4/dependencies/rhcos/4.3/4.3.0/rhcos-4.3.0-x86_64-installer-initramfs.img
# wget https://mirror.openshift.com/pub/openshift-v4/dependencies/rhcos/4.3/4.3.8/rhcos-4.3.8-x86_64-installer-initramfs.x86_64.img
```

##### RHCOS metal BIOS image

```
# wget https://mirror.openshift.com/pub/openshift-v4/dependencies/rhcos/4.3/4.3.0/rhcos-4.3.0-x86_64-metal.raw.gz
# wget https://mirror.openshift.com/pub/openshift-v4/dependencies/rhcos/4.3/4.3.8/rhcos-4.3.8-x86_64-metal.x86_64.raw.gz
```

##### Always run restorecon after you placed the downloaded files

```
# restorecon -RFv <PATH TO THE LOCATION>
```

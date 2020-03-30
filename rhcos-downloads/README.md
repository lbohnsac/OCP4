# RHCOS (Red Hat Core OS) image download URLs

##### Installer kernel
```
# wget https://mirror.openshift.com/pub/openshift-v4/dependencies/rhcos/4.3/4.3.0/rhcos-4.3.0-x86_64-installer-kernel
```

##### Installer initramfs

```
# wget https://mirror.openshift.com/pub/openshift-v4/dependencies/rhcos/4.3/4.3.0/rhcos-4.3.0-x86_64-installer-initramfs.img
```

##### RHCOS metal BIOS image

```
# wget https://mirror.openshift.com/pub/openshift-v4/dependencies/rhcos/4.3/4.3.0/rhcos-4.3.0-x86_64-metal.raw.gz
```

##### Always run restorecon after you placed the downloaded files

```
# restorecon -RFv <PATH TO THE LOCATION>
```

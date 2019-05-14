# Mic Custom Kernel for Vero

This custom kernel enables support for running Docker Swarm on the Vero 4K.

After preparing the build environment according to the osmc documentation, [Getting involved with OSMC Development](https://osmc.tv/wiki/development/getting-involved-with-osmc-development).

Copy the customised config file from the `configs` directory into the osmc `patch` directory. 
The patch will be applied when the vero364 kernel is built.

```shell
$ cp config/vero364-005-add-mic-kernel-config.patch ../osmc/package/kernel-osmc/patches
```

This file was created by performing a `diff` between the vero364 config and the custom configuration.

```shell
$ cd config
$ diff -Naur vero_baseline_config mic_config
```

Build the new vero364 kernel

```shell
$ cd ../osmc/package/kernel-osmc
$ make vero364
```

Several `.deb` kernel packages will be created, install the image package.

```shell
$ dpkg -i vero364-image-3.14.29-135-osmc.deb
```

An example list of the files are below.

```shell
$ ls -l 
total 151600
-rw------- 1 pi pi   6690926 Jan  6 09:56 vero364-headers-3.14.29-135-osmc_135_arm64.deb
-rw------- 1 pi pi       956 Jan  6 09:56 vero364-kernel-3.14.29-135-osmc.deb
-rw------- 1 pi pi 115353620 Jan  6 09:57 vero364-source-3.14.29-135-osmc_135_all.deb
```

# Mic Custom Kernel for Vero

After preparing the build environment according to the osmc documentation.  Copy my customised config file into the `patch` directory. 
This will patch the vero364 kernel config.

```shell
$ cp vero364-005-add-mic-kernel-config.patch osmc/package/kernel-osmc/patches
```

This file was created by performing a `diff -Naur vero_baseline_config mic_config`.

Build the new kernel

```shell
$ cd osmc/package/kernel-osmc
$ make vero364
```

Several `.deb` kernel packages will be created, install the image package.

```shell
$ dpkg -i vero364-image-3.14.29-135-osmc.deb
```
total 151600
-rw------- 1 pi pi   6690926 Jan  6 09:56 vero364-headers-3.14.29-135-osmc_135_arm64.deb
-rw------- 1 pi pi       956 Jan  6 09:56 vero364-kernel-3.14.29-135-osmc.deb
-rw------- 1 pi pi 115353620 Jan  6 09:57 vero364-source-3.14.29-135-osmc_135_all.deb

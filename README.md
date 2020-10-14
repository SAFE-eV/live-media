# Prerequisites

An Arch Linux with the following packages installed:

* `archiso`

Additionally for testing:

* `qemu`
* `edk2-ovmf` (only needed to test UEFI boot)

# Summary

Minimal live system with just the basic things to get the software running:

* bootloader
* Intel and AMD microcode updates
* Linux kernel
* base system
* minimal desktop environment (XWayland + Mutter + GNOME shell)
* video drivers (all of them, meta package `xorg-drivers`)
* input drivers (Synaptics touch)
* Java runtime

For user convinience the following packages were added:

* GNOME's control center to make various changes like display resolution or keyboard layout
* Firefox web browser (access to backends via web providing the actual data)
* Network manager (network access)
* Nautilus file browser (in case data is available via an external media)
    * `dosfstools` to acceess external media with FAT file system
    * `exfatprogs` to acceess external media with exFAT file system
    * `ntfs-3g` to acceess external media with NTFS system

These are optional and could in theory be removed. However, at least a web browser (plus networking) or a file browser should be included to make data available.

For a complete list of packages see the `packages.x86_64` file.

## Measures

* minimal system
* hardened linux kernel (`linux-hardened`)
* latest and modern software components (Arch Linux' rolling release)
* no root login
* booting directly into desktop environment
* software is autostarting

## Credentials

There is only one default user named `user`. The password is `user`. These are only needed when logging out or locking the session, though. There is no access to root.

## Background image

by Philipp Katzenberger, Creative Commons License

https://unsplash.com/photos/iIJrUoeRoCQ

# Build

From within the repo:

```
# mkarchiso -v -w /tmp/archiso-tmp .
```

After successful build the ISO file will be located in the `out` directory.

Note that a generated checksum over the resulting image will most likely be different with every other build. The host system's mirrorlist is included within the build and also the latest version of each package is used. The primary use of a checksum in this case would be to check the integrity of the final ISO after download.

# Test

To test the ISO with qemu from within the repo:

```
$ run_archiso -i out/transparenzsoftware-v1.1.0_20XX.XX.XX-x86_64.iso
```

Add `-u` flag to test UEFI boot:

```
$ run_archiso -u -i out/transparenzsoftware-v1.1.0_20XX.XX.XX-x86_64.iso
```

# TODO

* UEFI boot (hybrid ISO)
* different browser?
* different desktop environment?

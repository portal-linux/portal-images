# portal-images

Builds and signs the curated Linux guest images for the Portal project.

Portal runs ARM64 Linux distros on Apple Silicon Macs using Apple's
Virtualization.framework. This repo is the image side of that project: it
produces the curated guest images the host app can download, verify, and boot.

## Curated distros

| Distro    | Build tool                    | Status                    |
| --------- | ------------------------------| ------------------------- |
| arch-spin | pacstrap + mkfs.ext4 (aarch64 chroot under qemu-user emulation) | working |
| Fedora    | mkosi                         | planned, not implemented  |
| Ubuntu    | mkosi                         | planned, not implemented  |
| Debian    | mkosi                         | planned, not implemented  |
| NixOS     | nix flake                     | planned, not implemented  |

The Arch spin is the project's own default image: a ready-to-boot raw ext4
disk image (plus extracted kernel and initramfs) built by bootstrapping the
official ArchLinuxARM rootfs and installing `packages.aarch64` into it via
`pacstrap` inside a chroot, under aarch64 emulation (GitHub's runners are
x86_64; ArchLinuxARM packages are aarch64). It ships a `portal` user, sshd
enabled, and cloud-init for unattended install.

Note: this is **not** built with `archiso`/`mkarchiso`, despite that being
the initial plan. `archiso` only supports the boot modes vanilla Arch Linux
ships for (`bios.syslinux`, `uefi.systemd-boot`) - there is no aarch64
variant, because Arch Linux itself is x86_64-only upstream (that's exactly
why the separate ArchLinuxARM project exists). Portal boots guests directly
from a kernel, initramfs, and disk image via `VZLinuxBootLoader`, so an
installer ISO was never actually needed - only the raw disk image is.

The other distros are on the roadmap; each has a placeholder README
describing how it will be built.

## Verification model

Every curated image ships two extra files alongside the image itself:

- a SHA-256 hash of the image
- a minisign signature

The host app checks both before boot. The hash catches corrupted or truncated
downloads; the minisign signature proves the image came from this project and
was not tampered with in transit or on a mirror. An image that fails either
check is not booted.

`manifest.json` is the index the host app reads. Each entry names the image,
its version, arch, expected SHA-256, signature, minimum compatible app version,
and download URL. The example entry in the committed manifest uses obvious
placeholder hash and signature values (all-zero hash, a clearly-fake
signature string) so nobody mistakes scaffold data for real signed data.

## Builds

Images are built in GitHub Actions on a weekly cron (and on manual
`workflow_dispatch`) and published to GitHub Releases. See
`.github/workflows/build-images.yml`. The `build-disk-image` job bootstraps
the rootfs, installs packages, builds the raw disk image, hashes it, signs it
with minisign using repo secrets, and uploads the image plus its `.sha256`,
`.minisig`, extracted `kernel`, and `initrd` to a release.

## Licensing

The scripts and tooling in this repo are licensed under Apache 2.0. See
`LICENSE`.

The guest images this repo produces are NOT covered by that license. Each
image is a build of an upstream distribution and inherits that distribution's
own license and the licenses of the packages it contains (Arch, Fedora,
Ubuntu, Debian, NixOS, and so on). Apache 2.0 here applies only to Portal's
own build scripts, profiles, and CI, not to the distributed images.

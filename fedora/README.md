# Fedora guest image

Fedora 41, aarch64. Built with mkosi (not archiso, which is Arch specific),
cross-built on the x86_64 CI runner via mkosi's arm64 user-mode emulation
support, the same qemu-user-static mechanism arch-spin uses for its chroot.

mkosi.conf lists the packages (sway, foot, mesa, NetworkManager, cloud-init).
mkosi.extra/ carries the portal cloud-init drop-in. sshd, NetworkManager, and
cloud-init.target are already enabled by their own rpm %post scriptlets, so
there is no separate postinst step to enable them, unlike arch-spin.

The resulting rootfs is turned into a raw ext4 disk image and the kernel and
initrd are extracted separately, exactly like arch-spin, since the host boots
the kernel and initrd directly rather than through a bootloader in the image.

Ships the same verification contract as every other curated image: a SHA-256
hash plus a minisign signature, checked by the host app before boot.

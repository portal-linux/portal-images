# Changelog

All notable changes to this project are documented here.

## [Unreleased]

- scaffold portal-images curated distro repo
- build and sign a ready-to-boot disk image on real linux, not macos
- switch to qemu-user-static package for aarch64 emulation in ci
- fix dns resolution, disk space, and chroot mount issues in the image build
- remove archiso iso build, arch linux has no aarch64 target upstream
- compress disk image before publishing (github release assets cap at 2gb)
- point arch-spin manifest at real disk-14 release with real hashes

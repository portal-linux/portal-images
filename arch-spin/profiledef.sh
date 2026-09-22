#!/usr/bin/env bash
# shellcheck disable=SC2034

iso_name="portal-arch"
iso_label="PORTAL_ARCH_$(date +%Y%m)"
iso_publisher="Portal Project <https://github.com/portal>"
iso_application="Portal Arch spin guest image"
iso_version="$(date +%Y.%m.%d)"
install_dir="portal"
buildmodes=('iso')
# aarch64 vm guest boots via uefi under apple virtualization.framework, no bios/mbr path needed
bootmodes=('uefi-aarch64.systemd-boot.esp' 'uefi-aarch64.systemd-boot.eltorito')
arch="aarch64"
pacman_conf="pacman.conf"
airootfs_image_type="squashfs"
airootfs_image_tool_options=('-comp' 'zstd' '-Xcompression-level' '19' '-b' '1M')
bootstrap_tarball_compression=('zstd' '-c' '-T0' '--auto-threads=logical' '--long' '-19')

file_permissions=(
  ["/etc/shadow"]="0:0:400"
  ["/etc/gshadow"]="0:0:400"
  ["/root"]="0:0:750"
  ["/root/.ssh"]="0:0:700"
  ["/usr/local/bin/"]="0:0:755"
)

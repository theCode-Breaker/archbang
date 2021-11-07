#!/usr/bin/env bash
# shellcheck disable=SC2034
# Modified for ArchBang

iso_name="archbang-autumn"
iso_label="ARCHBANG_$(date +%d%m)"
iso_publisher="ArchBang Linux <https://www.archbang.org>"
iso_application="ArchBang Linux Live/Rescue Iso"
iso_version="$(date +%d%m)"
install_dir="arch"
bootmodes=('bios.syslinux.mbr' 'bios.syslinux.eltorito' 'uefi-x64.systemd-boot.esp' 'uefi-x64.systemd-boot.eltorito')
arch="x86_64"
pacman_conf="pacman.conf"
airootfs_image_tool_options=('-comp' 'xz' '-Xbcj' 'x86' '-b' '1M' '-Xdict-size' '1M')
file_permissions=(
  ["/etc/shadow"]="0:0:400"
  ["/root"]="0:0:750"
  ["/etc/skel/Scripts/"]="0:0:755"
 # ["/etc/skel/Scripts/config_edit"]="0:0:755"
 # ["/etc/skel/Scripts/packey"]="0:0:755"
  ["/root/mvuser"]="0:0:755"
)

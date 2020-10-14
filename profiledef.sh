#!/usr/bin/env bash
# shellcheck disable=SC2034

iso_name="transparenzsoftware"
iso_label="LIVE_$(date +%Y%m)"
iso_publisher="S.A.F.E. e.V. <https://safe-ev.de>"
iso_application="Transparenzsoftware"
iso_version="v1.1.0_$(date +%Y.%m.%d)"
install_dir="arch"
bootmodes=('bios.syslinux.mbr' 'bios.syslinux.eltorito')
arch="x86_64"
pacman_conf="pacman.conf"

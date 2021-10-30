#!/bin/bash
# Configure live iso

set -e -u -x
shopt -s extglob

# Set locales
sed -i 's/#\(en_GB\.UTF-8\)/\1/' /etc/locale.gen
locale-gen

# Sudo to allow no password
sed -i 's/# %wheel ALL=(ALL) NOPASSWD: ALL/%wheel ALL=(ALL) NOPASSWD: ALL/g' /etc/sudoers
chown -c root:root /etc/sudoers
chmod -c 0440 /etc/sudoers

# Hostname
echo "archbang" > /etc/hostname

#  Hosts file to archbang (test version)
sed -i "0,/127.0.0.1/s/localhost/archbang/2" /etc/hosts

# Vconsole
echo "KEYMAP=gb" > /etc/vconsole.conf
echo "FONT=" >> /etc/vconsole.conf

# Locale
echo "LANG=en_GB.UTF-8" > /etc/locale.conf
echo "LC_COLLATE=C" >> /etc/locale.conf

# Set clock to UTC
hwclock --systohc --utc

# Timezone
ln -sf /usr/share/zoneinfo/Europe/London /etc/localtime

# Add live user
useradd -m -p "" -g users -G "wheel" -s /bin/bash ablive
chown ablive /home/ablive

# Add +x to Scripts and mvuser...
chmod +x /root/mvuser
chmod +x /etc/skel/Scripts/{abinstall,packey}

# Fix htop looking for xterm
ln -s /usr/bin/lxterminal /usr/bin/xterm

# remove desktop files
path="/usr/share/applications"

desk_file='avahi-discover bvnc bssh volumeicon gparted conky tint2 pcmanfm-desktop-pref qv4l2 qvidcap'

for rem in ${desk_file}
do
   mv ${path}/${rem}.desktop ${path}/${rem}.hide
done

# remove icon set ...
#pacman -Rdd  adwaita-icon-theme --noconfirm

# Start required systemd services
systemctl enable {pacman-init,NetworkManager}.service -f

#systemctl set-default multi-user.target
systemctl set-default graphical.target


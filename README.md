# Setup Machines

## Linux

### Nvidia Graphics

```bash
# https://launchpad.net/~graphics-drivers/+archive/ubuntu/ppa
sudo add-apt-repository ppa:graphics-drivers/ppa
sudo apt-get update
sudo apt-get install nvidia-driver-418
```

### Fix screen tearing on Laptop

```bash
sudo echo "options nvidia_drm modeset=1" > /etc/modprobe.d/zzz-nvidia-drm.conf
sudo update-initramfs -u
reboot
```

### Install Sublime Merge & Sublime Text

```bash
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
sudo apt-get install apt-transport-https
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
sudo apt-get update
sudo apt-get install sublime-merge sublime-text
```

### Dropbox icon on status bar

From: https://pop.system76.com/docs/status-icons/

```
sudo apt install gnome-shell-extension-appindicator
gnome-shell-extension-prefs
```

**Enable the last extension**.

### KeepassXC repository on Pop! OS

Run:
```
sudo add-apt-repository ppa:phoerious/keepassxc
```

Then, inside `/etc/apt/preferences.d/extra-settings` write this:

```
Package: keepassxc
Pin: release o=LP-PPA-phoerious-keepassxc
Pin-Priority: 2000
```

Finally

```
sudo apt update
sudo apt install keepassxc
```

### Show seconds in Gnome3 top clock

```bash
sudo apt install gnome-tweak-tool
gnome-tweaks # And use the GUI for that
```

### Display only current workspace's programs in Ubuntu Dock

```bash
gsettings set org.gnome.shell.extensions.dash-to-dock isolate-workspaces true
```

### Some random WiFi or wired network doesn't resolve DHCP properly.

```bash
# See if there are dhcp problems in syslog
cat /var/log/syslog | grep <network-card>
# Check if dhcp resolution works with dhclient
sudo dhclient -v <network-card>
```

Add this to `main` section in `/etc/NetworkManager/NetworkManager.conf`. [Docs](https://developer.gnome.org/NetworkManager/stable/NetworkManager.conf.html).
```
dhcp=dhclient
```

## Windows

### Fix wrong time on every reboot when having dual boot

```bash
# Steps to do first in Linux
ntpdate pool.ntp.org
hwclock –systohc –utc
```

- Enter regedit (`Windows + R` -> `regedit`).
- Navigate to `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\TimeZoneInformation`.
- Add `DWORD (32-bit)` with key `RealTimeIsUniversal`.
- Set the value to `1`.

https://windowsreport.com/fix-windows-10-clock/

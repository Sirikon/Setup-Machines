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

### Priorize KeepassXC repository on Pop! OS

Inside `/etc/apt/preferences.d/extra-settings`

```
Package: keepassxc
Pin: release o=LP-PPA-phoerious-keepassxc
Pin-Priority: 2000
```

Then

```
sudo apt update
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

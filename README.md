# Setup Linux Machines

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

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

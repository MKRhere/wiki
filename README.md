# MKRhere/wiki

A personal repository for common problems and solutions.

I created this repo so that I don't have to go back and lookup solutions to problems I've already encountered. Feel free to use this repo if it solves your own problems, and raise an issue if you think something can be less hacky or retarded.

## Table of contents

- [Debian GNU/Linux](#debian-gnulinux)
    - [Nvidia drivers](#nvidia-drivers)
    - [OBS with NVENC](#obs-with-nvenc)
    - [Intel WiFi drivers](#intel-wifi-drivers)
    - [MongoDB](#mongodb)
    - [nodejs](#nodejs)
        - [Installing and using ~~nvm~~ nvs](#installing-and-using-nvm-nvs)
    - [PulseAudio](#pulseaudio)
    - [Peek](#peek)
    - [resolv.conf](#resolvconf)
    - [RabbitMQ Server](#rabbitmq-server)
    - [_MISC](#_misc)

## Debian GNU/Linux

### NVIDIA drivers with CUDA

Don't fight it. Just download the entire bundle from NVIDIA. Get the latest CUDA deb URL from https://developer.nvidia.com/cuda-downloads and follow the instructions below:

```shell
wget https://developer.download.nvidia.com/compute/cuda/11.7.0/local_installers/cuda-repo-debian11-11-7-local_11.7.0-515.43.04-1_amd64.deb
sudo dpkg -i cuda-repo-debian11-11-7-local_11.7.0-515.43.04-1_amd64.deb
sudo cp /var/cuda-repo-debian11-11-7-local/cuda-*-keyring.gpg /usr/share/keyrings/
sudo add-apt-repository contrib
sudo apt-get update
sudo apt-get -y install cuda
```

### OBS with NVENC

Once you've installed NVIDIA drivers with CUDA support above, do this (adapted [from Arch Wiki](https://wiki.archlinux.org/title/NVIDIA#Hardware_accelerated_video_encoding_with_NVENC)):

NVENC requires the `nvidia_uvm` module and the creation of related device nodes under `/dev`. Invoking the nvidia-modprobe utility automatically creates them. You can create /etc/udev/rules.d/70-nvidia.rules to run it automatically:

```txt
/etc/udev/rules.d/70-nvidia.rules

ACTION=="add", DEVPATH=="/bus/pci/drivers/nvidia", RUN+="/usr/bin/nvidia-modprobe -c0 -u"
```

Running `nvidia-modprobe -c0 -u` once also does it.

After ensuring `/dev/nvidia-uvm` exists, install OBS from Flatpak to save the trouble of installing it by hand. Choose NVENC and hit record. It just works now!

### Intel WiFi drivers

Intel WiFi drivers are not included in the Debian official repos. They are only available from the non-free repo.

```shell
echo "deb http://httpredir.debian.org/debian/ stretch main contrib non-free" >> /etc/apt/sources.list
sudo apt-get update
sudo apt-get install firmware-iwlwifi
```

### MongoDB

MongoDB has [Debian Buster packages now](https://www.mongodb.com/docs/manual/tutorial/install-mongodb-on-debian/), which works fine on Debian Bullseye.

### nodejs

Install Node globally from [Nodesource](https://github.com/nodesource/distributions#deb=):

```shell
# Using Debian
sudo su
curl -fsSL https://deb.nodesource.com/setup_18.x | bash -
apt-get install -y nodejs
```

Install Node locally (preferred) using [NVS](https://github.com/jasongin/nvs):

```shell
export NVS_HOME="$HOME/.nvs"
git clone https://github.com/jasongin/nvs "$NVS_HOME"
. "$NVS_HOME/nvs.sh" install
```

### PulseAudio

Had an issue on Debian Stretch on my Dell PC where pulseaudio daemon won't autostart. This solved the problem each time:

```shell
pulseaudio --start
sudo killall -9 pulseaudio
sudo systemctl --user enable pulseaudio.socket
pulseaudio --start
```

### Peek

[Peek](https://github.com/phw/peek#debian) is a GIF recorder for Linux.

There are no official Debian packages, yet, but you can easily create your own .deb package for Peek. First, install the build dependencies:

```shell
sudo apt install cmake valac libgtk-3-dev libkeybinder-3.0-dev libxml2-utils gettext txt2man
```

Then build Peek and package it:

```shell
git clone https://github.com/phw/peek.git
mkdir peek/build
cd peek/build
cmake -DCMAKE_INSTALL_PREFIX=/usr -DGSETTINGS_COMPILE=OFF ..
make package
```

This will create the package peek-x.y.z-Linux.deb (where x.y.z is the current version). You can install it with dpkg:

```shell
sudo dpkg -i peek-*-Linux.deb
```

### resolv.conf

Trouble with random daemons overwriting `resolv.conf`? Unsure if it's network manager or netconfig or dhcpcd? Simple hack:

```shell
chattr +i /etc/resolv.conf
```

> Note to future self: If later you found the right way to do this, reverse the above by doing `chattr -i /etc/resolv.conf` and fix it.

#### Future self:

To add nameservers before `resolv.conf`, add `prepend domain-name-servers 127.0.0.1;` to `/etc/dhcp/dhclient.conf`.

As implied, `nameserver 127.0.0.1` is prepended to `/etc/resolv.conf`

### _MISC

<details>
<summary>Useful Linux commands</summary>

- Information about graphic card:
	- `sudo lspci -v -s 01:00.0`
	- `inxi -Gx`
- List all shell commands available `compgen -c` (use with `grep`?)
</details>

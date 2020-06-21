# MKRhere/wiki

A personal repository for common problems and solutions.

I created this repo so that I don't have to go back and lookup solutions to problems I've already encountered. Feel free to use this repo if it solves your own problems, and raise an issue if you think something can be less hacky or retarded.

## Table of Content

- [Debian GNU/Linux](#debian-gnulinux)
    - [AMD Radeon drivers](#amd-radeon-drivers)
    - [Crystal](#crystal)
    - [dirmngr](#dirmngr)
    - [Erlang](#erlang)
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

### AMD Radeon drivers

This package contains the binary firmware for AMD/ATI graphics chips supported by the radeon, amdgpu and r128 drivers, not included in the official ISO.

```shell
sudo apt-get update
sudo apt-get install firmware-amd-graphics
```

### Crystal

To install Crystal, you will need to add their apt repository. Their `setup.sh` script helps simplify this.

⚠️ Needs `dirmngr` to get authentication keys

```shell
curl https://dist.crystal-lang.org/apt/setup.sh | sudo bash
sudo apt-get install build-essential
sudo apt-get install crystal
```

### dirmngr

dirmngr is a server for managing and downloading OpenPGP and X.509 certificates, as well as updates and status signals related to those certificates. For OpenPGP, this means pulling from the public HKP/HKPS keyservers, or from LDAP servers. For X.509 this includes Certificate Revocation Lists (CRLs) and Online Certificate Status Protocol updates (OCSP). It is capable of using tor for network access.

```shell
sudo apt-get update
sudo apt-get install dirmngr
```

### Erlang

Installing `erlang` from erlang-solutions:

```shell
wget https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb
sudo dpkg -i erlang-solutions_1.0_all.deb

sudo apt-get update

# Install one of the following

# Install erlang
sudo apt-get install erlang
# or install esl-erlang - includes the Erlang/OTP platform and all of its applications
sudo apt-get install esl-erlang
```

### Intel WiFi drivers

Intel WiFi drivers are not included in the Debian official repos. They are only available from non-free repo.

```shell
echo "deb http://httpredir.debian.org/debian/ stretch main contrib non-free" >> /etc/apt/sources.list
sudo apt-get update
sudo apt-get install firmware-iwlwifi
```

### MongoDB

~~MongoDB doesn't have official packages for Debian Stretch at this moment, so we'd have to install from the Jessie repository which will throw an error saying the dependency `libssl1.0.0` will not be satisfied.~~

MongoDB has Debian Stretch packages now!

```shell
# Get signing keys
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2930ADAE8CAF5059EE73BB4B58712A2291FA4AD5

# Add the Debian Stretch repo
echo "deb http://repo.mongodb.org/apt/debian stretch/mongodb-org/3.6 main" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.6.list

# Install mongodb
sudo apt-get update
sudo apt-get install mongodb-org
```

### nodejs

nodejs apt repository is several years behind, so add nodesource repos. nodejs 9.x (current version)

```shell
# Using Debian
sudo su
curl -sL https://deb.nodesource.com/setup_9.x | bash -
apt-get install -y nodejs
```

#### Installing and using ~~nvm~~ nvs

You may need to use multiple node versions on the same machine. ~~`nvm` will be very useful in this case.~~ [`nvs`](https://github.com/jasongin/nvs) is a much better, cross-platform implementation.

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

### RabbitMQ Server

Installing RabbitMQ Server on Debian Stretch fails because the dependent packages `erlang-nox` and `esl-erlang` on Debian repos are slightly outdated. Hence, follow these instructions:

Install [Erlang](#erlang) first.

```shell
# Add RabbitMQ repo from bintray to sources, but don't install it yet
echo "deb https://dl.bintray.com/rabbitmq/debian stretch main" | sudo tee /etc/apt/sources.list.d/bintray.rabbitmq.list
sudo apt update

# Try installing erlang-nox
sudo apt-get install erlang-nox

# You might get these errors:
# erlang-nox : Depends: erlang-diameter but it is not going to be installed
#              Depends: erlang-eldap but it is not going to be installed
# If you do so, try this:
sudo apt-get install erlang-diameter erlang-eldap
# Now this should install properly:
sudo apt-get install erlang-nox

# Now actually install RabbitMQ:
sudo apt-get install rabbitmq-server
```

RabbitMQ Server should have automatically started by now, but if it is not, run `rabbitmq-server start` (sudo if required).

### _MISC

<details>
<summary>Useful Linux commands</summary>

- Information about graphic card:
	- `sudo lspci -v -s 01:00.0`
	- `inxi -Gx`
- List all shell commands available `compgen -c` (use with `grep`?)
</details>

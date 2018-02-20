# MKRhere/wiki

A personal repository for common problems and solutions.

I created this repo so that I don't have to go back and lookup solutions to problems I've already encountered. Feel free to use this repo if it solves your own problems, and raise an issue if you think something can be less hacky or retarded.

## Debian GNU/Linux

### AMD Radeon drivers

This package contains the binary firmware for AMD/ATI graphics chips supported by the radeon, amdgpu and r128 drivers, not included in the official ISO.

```shell
sudo apt-get update
sudo apt-get install firmware-amd-graphics
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

### nodejs

nodejs apt repository is several years behind, so add nodesource repos. nodejs 9.x (current version)

```shell
# Using Debian
sudo su
curl -sL https://deb.nodesource.com/setup_9.x | bash -
apt-get install -y nodejs
```

#### Installing and using nvm

You may need to use multiple node versions on the same machine. `nvm` will be very useful in this case.

```shell
# using curl
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.8/install.sh | bash

# or wget
wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.33.8/install.sh | bash

# Optional: Add "| NVM_DIR=/path/to/nvm bash" to the end of the above line if you need to change install directory
# "| NVM_DIR=/usr/local/nvm bash" for global (all users) install
```

And then add this to your `~/.bashrc` or `~/.zshrc`:

```shell
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
```

### MongoDB

MongoDB doesn't have official packages for Debian Stretch at this moment, so we'd have to install from the Jessie repository which will throw an error saying the dependency `libssl1.0.0` will not be satisfied.

#### Installing MongoDB on Debian Stretch

```shell
# Get signing keys
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2930ADAE8CAF5059EE73BB4B58712A2291FA4AD5

# Add the Debian 8 repo
echo "deb http://repo.mongodb.org/apt/debian jessie/mongodb-org/3.6 main" | sudo tee

# Download libssl1.0.0 deb file and install
TEMP_DEB="$(mktemp)" &&
wget -O "$TEMP_DEB" 'security.debian.org/debian-security/pool/updates/main/o/openssl/libssl1.0.0_1.0.1t-1+deb7u3_amd64.deb' &&
sudo dpkg -i "$TEMP_DEB"
rm -f "$TEMP_DEB"

# Install mongodb
sudo apt-get update
sudo apt-get install mongodb-org
```

### PulseAudio

Had an issue on Debian Stretch on my Dell PC where pulseaudio daemon won't autostart. This solved the problem each time:

```shell
pulseaudio --start
sudo killall -9 pulseaudio
sudo systemctl --user enable pulseaudio.socket
pulseaudio --start
```

### RabbitMQ Server

Installing RabbitMQ Server on Debian Stretch fails because the dependent packages `erlang-nox` and `esl-erlang` on Debian repos are slightly outdated. Hence, follow these instructions:

Install [Erlang](#erlang) first.

```shell
# Add RabbitMQ repo from bintray to sources, but don't install it yet
echo "deb https://dl.bintray.com/rabbitmq/debian stretch main" | sudo tee /etc/apt/sources.list.d/bintray.rabbitmq.list
sudo apt update

# Try installing erlang-nox
sudo apt-get install erlang-nox

# You might get this errors:
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

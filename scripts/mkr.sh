# mkr.sh

## A list of commands to simplify my life
## Read carefully, use at your own risk
## Add 'source path/to/mkr.sh' in your ~/.bashrc or ~/.zshrc

mkdir -p $HOME/.mkr/bin
export PATH="$PATH:$HOME/.mkr/bin"

# Actually clear your terminal

alias cls='printf "\033c"'

# Copy to clipboard

## clip
## Usage: cat <file> | clip
## Copies output from previous command into clipboard
alias clip="xclip -selection clipboard"

# Directory management

## mk
## Usage: mk <dir>
## Makes a new directory and enters it
mkd () {
	mkdir -p "$1"
	cd "$_"
}

## rmd
## Usage: rmd [dir]
## Use with caution: Removes current working directory and changes to one up level
## If an argument is passed, simply deletes that file or folder from current working directory

rmd () {
	CWD="$PWD"
	if [ "$1" ]; then
		rm -rf "$1"
	else
		cd ..
		rm -rf "$CWD"
	fi
}

# Git commands

## git graph
## Usage: git graph
git config --global alias.graph 'log --graph --date-order --pretty=format:"%C(bold yellow)%h%C(auto)%d %C(cyan)%an%C(bold white) %s %C(auto)%C(green)(%ar)%C(reset)"'


# Systemctl commands

## status
## Usage: status <daemon>
status () {
	sudo systemctl status "$1"
}

## start
## Usage: start <daemon>
start () {
	sudo systemctl start "$1"
}

## stop
## Usage: stop <daemon>
stop () {
	sudo systemctl stop "$1"
}

# MISC

## mkr-update
## Usage: mkr-update
mkr-update () {
	curl -s https://raw.githubusercontent.com/MKRhere/wiki/master/scripts/mkr.sh -o ~/.mkr/mkr.sh
	source ~/.mkr/mkr.sh
	echo "[mkr.sh] Done updating script! Enjoy."
}

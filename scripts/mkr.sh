# mkr.sh

## A list of commands to simplify my life
## Read carefully, use at your own risk
## Add 'source path/to/mkr.sh' in your ~/.bashrc or ~/.zshrc

# Actually clear your terminal

alias cls='printf "\033c"'

# Copy to clipboard

## clip
## Usage: cat <file> | clip
## Copies output from previous command into clipboard
alias clip="xclip -selection clipboard"

# Simpler apt commands

alias update="sudo apt-get update"
alias i="sudo apt-get install -y"
alias purge="sudo apt purge -y"
alias ar="sudo apt autoremove -y"
alias autoremove="sudo apt autoremove -y" # Alias of ar

## To install without -y

alias install="sudo apt-get install"

# Directory management

## mk
## Usage: mk <dir>
## Makes a new directory and enters it
mk () {
	mkdir "$1"
	cd "$_"
}

## rmd
## Usage: rmd [dir]
## Use with caution: Removes current working directory and changes to one up level
## If an argument is passed, simply deletes that file or folder from current working directory

rmd () {
	CWD="$(dirname $(realpath $0))"
	if [ "$1" ]; then
		rm -rf "$1"
	else
		cd ..
		rm -rf "$CWD"
	fi
}

# Git commands

## pull
## Usage: pull [remote branch]
pull () {
	if [ "$1" ]; then
		git pull "$1" "$2"
	else
		git pull
	fi
}

## commit
## Usage: commit <commit-message>
commit () {
	git add .
	git commit -m "$1"
}

## push
## Usage: push <commit-message> [remote branch]
## if only commit message is present, pushes to default upstream

push () {
	git add .
	git commit -m "$1"
	if [ "$2" ]; then
		git push -u "$2" "$3"
	else
		git push
	fi
}

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
	curl https://raw.githubusercontent.com/MKRhere/wiki/master/scripts/mkr.sh -o ~/.mkr/mkr.sh
	source ~/.mkr/mkr.sh
}
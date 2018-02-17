# mkr.sh
## A list of commands to simplify my life
## Read carefully, use at your own risk
## Add 'source path/to/mkr.sh' in your ~/.bashrc or ~/.zshrc

# Simpler apt commands

alias update="sudo apt-get update"
alias i="sudo apt-get install -y"
alias purge="sudo apt purge -y"
alias ar="sudo apt autoremove -y"
alias autoremove="sudo apt autoremove -y" # Alias of ar

## To install without -y

alias install="sudo apt-get install"

# Directory management

## mk <dir>
## Makes a new directory and enters it
mk () {
	mkdir "$1"
	cd "$_"
}

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

## Usage: push "<Commit Message>" [remote branch]
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

status () {
	sudo systemctl status "$1"
}

start () {
	sudo systemctl start "$1"
}

stop () {
	sudo systemctl stop "$1"
}
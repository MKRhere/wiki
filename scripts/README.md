# mkr.sh

I made this script for my own convenience. Use at your own risk. Plenty of comments are supplied for each command. If you don't understand something, please don't use it.

## Install

Automatically add this script to your `~/.bashrc` or `~/.zshrc`:

```bash
mkdir ~/.mkr && curl https://raw.githubusercontent.com/MKRhere/wiki/master/scripts/mkr.sh -o ~/.mkr/mkr.sh

# if using bash
echo "source ~/.mkr/mkr.sh" >> ~/.bashrc
# or zsh
echo "source ~/.mkr/mkr.sh" >> ~/.zshrc

# To start using right away without waiting for shell restart
source ~/.mkr/mkr.sh

# updating script
mkr-update
```

## Commands

- General
	- `cls` : Clears screen
	- `clip` : Copies to clipboard
- apt
	- `i <package-names...>` : Accepts prompts and installs packages
	- `install <package-names...>` : Installs packages without auto-accepting
	- `update` : Equivalent to `apt-get update`
	- `purge <package-names...>` : Removes packages
	- `ar` / `autoremove` : Equivalent to `apt autoremove`
- Directories
	- `mkd </path/to/dir>` : Creates dir at given path and changes cwd to it
	- `rmd [dir]` : Removes current directory and moves up OR removes directory by given name
- git
	- `commit <commit-message>` : Adds all untracked files and commits them
	- `push <commit-message> [remote branch]` : Adds all untracked files, commits and pushes them
	- `dotgit [commands...]` : Requires a `~/.dotfiles` bare repo to exist
		- `-u` to commit to the dotgit repo
		- `-p` to push the dotgit repo to remote
- systemctl
	- `status <daemon>`
	- `start <daemon>`
	- `stop <daemon>`

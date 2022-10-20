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
- Directories
	- `mkd </path/to/dir>` : Creates dir at given path and changes cwd to it
	- `rmd [dir]` : Removes current directory and moves up OR removes directory by given name
- systemctl
	- `status <daemon>`
	- `start <daemon>`
	- `stop <daemon>`

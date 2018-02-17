# mkr.sh

I made this script for my own convenience. Use at your own risk. Plenty of comments are supplied for each command. If you don't understand something, please don't use it.

## Install

Add this script to your `~/.bashrc` or `~/.zshrc`:

```bash
mkdir ~/.mkr && curl https://raw.githubusercontent.com/MKRhere/wiki/master/scripts/mkr.sh -o ~/.mkr/mkr.sh

# if using bash
echo "source ~/.mkr/mkr.sh" >> ~/.bashrc
# or zsh
echo "source ~/.mkr/mkr.sh" >> ~/.zshrc

# updating script
mkr-update
```

## Commands

- General
	- `cls`
- apt
	- `i <package-name>`
	- `install <package-name>`
	- `update`
	- `purge <package-name>`
	- `ar` / `autoremove`
- Directories
	- `mk <dir>`
	- `rmd [dir]`
- git
	- `commit <commit-message>`
	- `push <commit-message> [remote branch]`
- systemctl
	- `status <daemon>`
	- `start <daemon>`
	- `stop <daemon>`
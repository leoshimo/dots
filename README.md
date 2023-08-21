# dots

leoshimo's dotfiles repository for linux and macOS machines.
See `make help` for overview.

## Setup

```sh
# SSH Setup w/ GH
$ ssh-keygen -t ed25519 -C "NAME_OF_MACHINE"

# Setup Repo in HOME
$ git clone git@github.com:leoshimo/dots.git
$ make setup

# Specific setup
$ make help        # see all commands
$ make pkg_all     # install packages
$ make link        # relink symlinks
```

# dots

leoshimo's dotfiles repository for linux and macOS machines.
See `make help` for overview.

## Setup

```sh
$ ssh-keygen -t ed25519 -C "NAME_OF_MACHINE"
$ git clone git@github.com:leoshimo/dots.git
$ make setup

$ make help        # see all commands
$ make pkg_all     # install packages
$ make link        # relink symlinks
$ make repos       # clone repos
```

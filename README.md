# dots

leoshimo's dotfiles repository for linux and macOS machines.
See `make help` for overview.

## Installation

```sh
$ ssh-keygen -t ed25519 -C "<NAME_OF_MACHINE>"

# Via Brew / GH:
$ brew install gh
$ gh auth login
$ gh repo clone leoshimo/dots
```

## Usage

```sh
# Setup - All
$ make setup

# Setup - Minimal
$ make setup_minimal

$ make help        # see all commands
$ make pkg_all     # install packages
$ make link        # relink symlinks
$ make repos       # clone repos
```

# Config

export EDITOR=vim
export VISUAL=vim
export PAGER=less
export TERM='xterm-256color'

## Paths
path=(
  $HOME/.cargo/bin
  $HOME/.zigup/bin
  /opt/homebrew/bin
  $HOME/.mint/bin
  $HOME/dots/bin
  $path
)

## Functions
export ZFUNC_DIR=$HOME/.zsh/funcs          # autoload functions
fpath=(
  $ZFUNC_DIR
  $fpath
)
# Autoload funcs
autoload -Uz $ZFUNC_DIR/*(.:t)

# Consistent Backspace
bindkey -M viins '^?' backward-delete-char
bindkey -M viins '^H' backward-delete-char

# Colors
autoload -Uz colors && colors

# History
HISTFILE=${ZDOTDIR:-$HOME}/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_IGNORE_DUPS
setopt INC_APPEND_HISTORY

# Directory Navigation
setopt AUTO_PUSHD		        # `cd` behaves like `pushd`
setopt PUSHD_IGNORE_DUPS		# `pushd` ignores duplicates
setopt PUSHD_SILENT		        # `pushd` is silent
setopt PUSHDMINUS		        # Use minus to specify dir stack

# Completion
autoload -Uz compinit && compinit -i        # ignore insecure
setopt GLOB_COMPLETE        # Glob is useful for finding branches e.g. ls/*-topic
zmodload zsh/complist		# For Menu Complete
setopt AUTO_MENU		# MENU completion for <TAB> <TAB> in multiple-match situations
unsetopt MENU_COMPLETE		# Unset in favor of AUTO_MENU
setopt COMPLETE_IN_WORD		# <TAB> completions work in-word
_comp_options+=(globdots)	# Show hidden files in completion
zstyle ':completion:*:*:*:*:*' menu select						                    # Show completions in menu
zstyle ':completion:*' matcher-list 'm:{a-zA-Z-_}={A-Za-z_-}' 'r:|=*' 'l:|=* r:|=*'	# Completions are case insensitive
zstyle ':completion:*' list-colors '${LS_COLORS}'					                # Completion colored by type
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=29=34'

# Vi: Mode map
bindkey -v			# Vim mode
export KEYTIMEOUT=1		# Snappier <ESC>

# Vi: Edit commands in vim via `ESC+v`
autoload -Uz edit-command-line; zle -N edit-command-line
bindkey -M vicmd 'v' edit-command-line			# Bind 'v' in NORMAL mode

# Vi: Completion Navigation (Must be after complist)
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history


# fzf
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# zoxide
eval "$(zoxide init zsh --cmd j)"

# iex
export ERL_AFLAGS="-kernel shell_history enabled"

# plan9port
export PLAN9=/Users/leoshimo/proj/plan9port export PLAN9
export PATH=$PATH:$PLAN9/bin export PATH

# lsregister
export PATH="/System/Library/Frameworks/CoreServices.framework/Versions/A/Frameworks/LaunchServices.framework/Versions/A/Support:$PATH"

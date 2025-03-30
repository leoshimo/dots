
# Source configs
for config (~/.zsh/*.zsh)
    source $config

export PATH="/opt/homebrew/opt/avr-gcc@8/bin:$PATH"

# Created by `pipx` on 2023-10-26 11:33:54
export PATH="$PATH:$HOME/.local/bin"

# vrsjmp bindings
run_vrsjmp_cli () {
    tmux popup -h 80% -w 80% \
         -E "$HOME/proj/vrs/scripts/vrsjmp_cli.sh"
}
zle -N run_vrsjmp_cli
bindkey '^g' run_vrsjmp_cli

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
# Added by LM Studio CLI tool (lms)
export PATH="$PATH:$HOME/.cache/lm-studio/bin"

# bun completions
[ -s "/Users/leoshimo/.bun/_bun" ] && source "/Users/leoshimo/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

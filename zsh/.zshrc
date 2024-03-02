
# Source configs
for config (~/.zsh/*.zsh)
    source $config

export PATH="/opt/homebrew/opt/avr-gcc@8/bin:$PATH"

# Created by `pipx` on 2023-10-26 11:33:54
export PATH="$PATH:/Users/leoshimonaka/.local/bin"

# vrsjmp bindings
run_vrsjmp_cli () {
    tmux popup -h 80% -w 80% \
         -E /Users/leoshimonaka/proj/vrs/scripts/vrsjmp_cli.sh
}
zle -N run_vrsjmp_cli
bindkey '^g' run_vrsjmp_cli

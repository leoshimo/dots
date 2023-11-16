
# Source configs
for config (~/.zsh/*.zsh)
    source $config

export PATH="/opt/homebrew/opt/avr-gcc@8/bin:$PATH"

# Created by `pipx` on 2023-10-26 11:33:54
export PATH="$PATH:/Users/leoshimonaka/.local/bin"

# Temp Bindings!
run_launcher () {
    tmux popup -h 80% -w 80% \
         -E /Users/leoshimonaka/proj/vrs/scripts/launcher_cli.sh
}
zle -N run_launcher
bindkey '^g' run_launcher

add_to_launcher () {
    tmux popup -h 80% -w 80% \
         -E /Users/leoshimonaka/proj/vrs/scripts/add_to_launcher_cli.sh
}
zle -N add_to_launcher
bindkey '^a' add_to_launcher

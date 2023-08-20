ANTIDOTE="$HOME/.antidote/antidote.zsh"
if [ -f "$ANTIDOTE" ]; then
    source "$ANTIDOTE"
    antidote load "$HOME/.zsh/antidote_plugins.txt"
fi

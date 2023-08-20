#  Shell Aliases

# ls
alias l='ls -FoG'
alias ll='ls -FoGa'

# git
alias g='git'

# vim
alias v="vim"

# Emacs
alias em='emacsclient --create-frame --alternate-editor="" -nw'
alias emk="pkill -USR2 emacs;  emacsclient -t -e '(save-buffers-kill-emacs)'"

# tmux
alias tn="tmux new"
alias ta="tmux attach"
alias td="tmux detach"
alias tw="tmux new-session -A -s workspace"

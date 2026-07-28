# Shell aliases managed by mac-bootstrap

# eza
if command -v eza >/dev/null 2>&1; then
  alias ls='eza'
  alias ll='eza --long --all --header --git'
  alias la='eza --all'
  alias lt='eza --tree --level=2'
fi

# bat
if command -v bat >/dev/null 2>&1; then
  alias bcat='bat'
fi

# Git
alias gs='git status'
alias ga='git add'
alias gaa='git add --all'
alias gc='git commit'
alias gca='git commit --amend'
alias gd='git diff'
alias gl='git log --oneline --decorate --graph --all'
alias gp='git push'
alias gpsup='git push --set-upstream origin "$(git branch --show-current)"'

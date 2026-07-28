# kubectl completion

if command -v kubectl >/dev/null 2>&1; then
  source <(kubectl completion zsh)

  alias k=kubectl
  complete -o default -F __start_kubectl k
fi

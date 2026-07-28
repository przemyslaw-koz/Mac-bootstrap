# Shell functions managed by mac-bootstrap

gac() {
  if [[ $# -eq 0 ]]; then
    echo 'Usage: gac "commit message"'
    return 1
  fi

  git add .
  git commit -m "$*"
}

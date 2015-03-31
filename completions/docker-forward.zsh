if [[ ! -o interactive ]]; then
    return
fi

compctl -K _docker-forward docker-forward

_docker-forward() {
  local word words completions
  read -cA words
  word="${words[2]}"

  if [ "${#words}" -eq 2 ]; then
    completions="$(docker-forward commands)"
  else
    completions="$(docker-forward completions "${word}")"
  fi

  reply=("${(ps:\n:)completions}")
}

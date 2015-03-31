_docker-forward() {
  COMPREPLY=()
  local word="${COMP_WORDS[COMP_CWORD]}"

  if [ "$COMP_CWORD" -eq 1 ]; then
    COMPREPLY=( $(compgen -W "$(docker-forward commands)" -- "$word") )
  else
    local command="${COMP_WORDS[1]}"
    local completions="$(docker-forward completions "$command")"
    COMPREPLY=( $(compgen -W "$completions" -- "$word") )
  fi
}

complete -F _docker-forward docker-forward

#!bash

_git_switch()
{
  local cur=${COMP_WORDS[COMP_CWORD]}
  local options="--checked-out --count= --help --modified --non-interactive --version"

  case $cur in
    --*=)
      # Avoid '--count=--count' edge cases
      ;;
    --*)
      COMPREPLY=( $(compgen -W "$options" -- $cur) )
      ;;
  esac
}

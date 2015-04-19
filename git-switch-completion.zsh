#!zsh

_git-switch()
{
  local -a options
  options=('--checked-out' '--count' '--help' '--modified' '--non-interactive' '--version')
  _describe 'values' options
}

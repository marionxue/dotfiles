# General settings
set -o noclobber
set -o ignoreeof

shopt -s cmdhist
shopt -s checkhash
shopt -s histappend
shopt -s checkwinsize
shopt -s cdspell
shopt -s login_shell
shopt -s extglob

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export EDITOR=vim
export HISTCONTROL=ignoreboth
export HISTFILESIZE=150000
export HISTSIZE=150000
export HISTTIMEFORMAT="%D %I:%M "
export PAGER=less
export LESS='-R -i -g'
export GREP_COLORS='1;37;41'
export MAIL=$HOME/.mail

# alias definitions
alias l='ls -lFha'
alias lt='ls -ltr'
alias h='history'
alias ..='cd ..'
alias grep='grep --color'
alias rmi='rm -i'
alias tree='tree -C'

# Set OS specific settings
OSTYPE=$( uname )

case $OSTYPE in
  Darwin)
    export PATH=$HOME/bin:/opt/local/bin:/usr/local/bin:/bin:/usr/bin:/sbin:/usr/sbin:/opt/local/sbin:/usr/X11/bin:$PATH
    export CLICOLOR=1
    export LSCOLORS=gxfxbEaEBxxEhEhBaDaCaD
    ;;
  Linux)
    export PATH=/bin:/sbin:/usr/local/bin::/usr/bin:/usr/sbin:bin:/usr/local/sbin
    export LS_OPTIONS='--color=auto'
    export LSCOLORS=GxFxCxDxbxDxDxxbadacad
    alias ls='ls -F --color'
    alias p='ps -ef'
    ;;
  *BSD)
    if [ -e /usr/local/bin/colors ]; then
      export LSCOLORS=GxFxCxDxBxDxDxxbadacad
      alias ls='colorls -FG'
    fi
    ;;
esac


_exitstatus ()
{

  EXITSTATUS="$?"

  local RED="\033[0;31m"

  if [ "${EXITSTATUS}" -ne 0 ]; then
    PS1="${RED}[$USER@\h:\w] \$ "
  else
    PS1="[$USER@\h:\w] \$ "
  fi

  # Secondary prompt
  PS2='> '
}

PROMPT_COMMAND=_exitstatus

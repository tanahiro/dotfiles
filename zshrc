############################################################
# zshrc
# vim: fileencoding=utf-8 foldmethod=marker
#
# Maintainer: Hiroyuki Tanaka <hryktnk@gmail.com>
# Last Change: 2014-02-08.
# License: Public Domain
############################################################

## history {{{
HISTFILE=~/.zhistory
SAVEHIST=5000
HISTSIZE=5000
# }}}
## functions {{{
autoload -U compinit
compinit

autoload -U colors
colors

autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
# }}}
## alias {{{
case "${OSTYPE}" in
  darwin*)
    lscommand="gls -F --color=auto -v --quoting-style=literal"
  ;;
  linux*|cygwin)
    lscommand="ls -F --color=auto -v"
  ;;
esac
alias ls="$lscommand"
alias	la="$lscommand -a"
alias	ll="$lscommand -l"

alias less="less -R"

alias	j=jobs

alias mv='nocorrect mv'
alias cp='nocorrect cp'
alias scp='nocorrect scp'
alias mkdir='nocorrect mkdir'

alias vi='vim'

alias ssh='ssh -Y'

alias grep='grep --color=always'

case "${OSTYPE}" in
  darwin*)
  alias gvim='open -a macvim'
  ;;
esac
# }}}
## global alias {{{
alias -g L='|less -R'
alias -g M='|more'
alias -g H='|head'
alias -g T='|tail'
alias -g G='|grep'
alias -g GI='|grep -i'
# }}}
## suffix alias {{{
alias -s rb=ruby

case "${OSTYPE}" in
  cygwin)
    alias -s html="cygstart firefox"
    ;;
esac
# }}}
## color {{{
case "${OSTYPE}" in
  darwin*)
    [ -r ~/.dir_colors ] && eval `gdircolors ~/.dir_colors`
  ;;
  linux*|cygwin)
    [ -r ~/.dir_colors ] && eval `dircolors ~/.dir_colors`
  ;;
esac
## }}}
## prompt {{{
case ${UID} in 
0)
  PROMPT="%j [%{${fg[cyan]}%}%U%m%{${reset_color}%}:%~%u]% %E
%h%{${fg[red]}%}%#>%{${reset_color}%}"
  PROMPT2="%{${fg[red]}%}%_->%{${reset_color}%}"
  ;;
*)
  case ${TERM} in
    screen*)
      PROMPT="%j [%{${fg[cyan]}%}%U${STY}%{${reset_color}%}:%~%u]% %E
%h%#>"
      PROMPT2="%_->"
      ;;
    *)
      PROMPT="%j [%{${fg[cyan]}%}%U%m%{${reset_color}%}:%~%u]% %E
%h%#>"
      PROMPT2="%_->"
      ;;
  esac
  ;;
esac
# }}}
## options {{{
##  history {{{
setopt hist_no_store
setopt hist_ignore_dups
setopt hist_ignore_space
setopt inc_append_history
setopt append_history
# }}}
##  directory {{{
setopt auto_cd
setopt auto_pushd
# }}}
##  complement {{{
setopt list_packed
setopt list_types
setopt complete_aliases
setopt auto_param_keys
setopt magic_equal_subst
# }}}
##  file name and glob {{{
setopt extended_glob
setopt numeric_glob_sort
unsetopt nomatch
# }}}
##  input/output {{{
setopt correct
setopt clobber
setopt correct_all
unsetopt flow_control
unsetopt ignore_eof
# }}}
##  jobs {{{
setopt auto_resume
# }}}
##  others {{{
setopt no_beep
setopt no_list_beep
setopt promptcr
setopt print_eight_bit
# }}}
# }}}
## bind key {{{
bindkey -e
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end 
# }}}
## completion in sudo {{{
zstyle ':completion:*:sudo:*' command-path\
  /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
## }}}
## terminal title {{{
case "${TERM}" in
  kterm*|xterm*)
    if [[ -n $STY ]]; then  ## screen
      preexec(){
        printf "\ek$1\e\\"  ## window title (latest command)
      }
      precmd(){
        ## title on terminal
        printf "\033P\033]0;@${HOST%%.*}:${PWD}\007\033\\"
      }
    else
    precmd(){
      printf "\e]0;@${HOST%%.*}:${PWD}\a"
    }
    fi
    ;;
  screen*)
    preexec(){
      printf "\ek$1\e\\"  ## window title (latest command)
    }
    precmd(){
      ## title on terminal
      #printf "\033P\033]0;@${HOST%%.*}:${PWD}\007\033\\"
      printf "\e]0;@${HOST%%.*}:${PWD}\a"
    }
    ;;
esac
# }}}
## others {{{
## default permissions
umask 022
# }}}
## local setting {{{
[ -f ~/.zshrc.local ] && source ~/.zshrc.local
# }}}
## rbenv {{{
[ -d ~/.rbenv ] && eval "$(~/.rbenv/bin/rbenv init - )"
# }}}
## pyenv {{{
[ -d ~/.pyenv ] && eval "$(~/.pyenv/bin/pyenv init - )"
# }}}
# tmux {{{
function tmux_ver() {
  local need_version=$1
  local current_version=$(tmux -V | awk '{print $2}')

  [[ $(echo "$current_version > $need_version" | bc) != 0 ]]
}
# }}}

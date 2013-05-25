############################################################
# zshenv
# vim: fileencoding=utf-8 foldmethod=marker
#
# Maintainer: Hiroyuki Tanaka <hryktnk@gmail.com>
# Last Change: 2013-05-25.
# License: Public Domain
############################################################

## path {{{
case "${OSTYPE}" in
  darwin*)
    path=(
      ~/usr/bin
      ~/.gem/ruby/current/bin
      /usr/local/bin
      /opt/local/bin
      /usr/bin
      /bin
      /usr/X11/bin
    )
    HOME=/Users/$USER
    ;;
  linux*)
    path=(
      ~/usr/bin
      ~/.gem/ruby/current/bin
      /usr/local/bin
      /usr/bin
      /bin
    )
    ;;
  cygwin)
    path=(
      ~/usr/bin
      /usr/local/bin
      /usr/bin
      /bin
    )
    ;;
esac
# }}}
## manpath {{{
case "${OSTYPE}" in
  darwin*)
    manpath=(
      /usr/local/share/man/ja
      /usr/local/share/man
      /opt/local/share/man/ja
      /opt/local/share/man
      /usr/share/man
    )
    ;;
  linux*)
    manpath=(
      /usr/local/share/man/ja
      /usr/local/share/man
      /usr/share/man/ja
      /usr/share/man
    )
    ;;
  cygwin)
    manpath=(
      /usr/local/man
      /usr/share/man
      /usr/man
    )
    ;;
esac
## }}}
typeset -U path cdpath fpath manpath

## TARGETOS {{{
case "${OSTYPE}" in
  darwin*)
    export TARGETOS=MAC
  ;;
  linux*)
    export TARGETOS=LINUX
  ;;
  cygwin)
    export TARGETOS=CYGWIN
esac

case "${OSTYPE}" in
  darwin*)
    export LIBTOOL=glibtool
  ;;
  linux*)
    export LIBTOOL=libtool
  ;;
esac
# }}}
## LD_LIBRARY_PATH {{{
case "${OSTYPE}" in
  darwin*)
    LD_LIBRARY_PATH=(
      ~/usr/lib
      /usr/local/lib
      /opt/local/lib
      /usr/lib
    )
    ;;
  linux*)
    LD_LIBRARY_PATH=(
      ~/usr/lib
      /usr/local/lib
      /usr/lib
    )
    ;;
esac
# }}}
## gnuplot {{{
case "${OSTYPE}" in
  darwin*)
    export GNUPLOT_FONTPATH=\
/usr/local/texlive/2009/texmf-dist/fonts/type1/urw/helvetic:\
/usr/local/texlive/2009/texmf-dist/fonts/type1/urw/times:\
/usr/local/texlive/2009/texmf-dist/fonts/type1/urw/symbol:\
/usr/local/texlive/2009/texmf-dist/fonts/type1/urw/courier
    export GDFONTPATH=/Library/Fonts
  ;;
  linux*)
    export GNUPLOT_FONTPATH=\
/usr/share/texmf-texlive/fonts/type1/urw/helvetic:\
/usr/share/texmf-texlive/fonts/type1/urw/times:\
/usr/share/texmf-texlive/fonts/type1/urw/symbol:\
/usr/share/texmf-texlive/fonts/type1/urw/courier
  ;;
esac
# }}}
## ruby {{{
case "${OSTYPE}" in
  darwin*)
    export GEM_HOME=${HOME}/.gem/ruby/current
    ;;
  linux*)
    export GEM_HOME=${HOME}/.gem/ruby/current
    ;;
esac
# }}}
## Other environment variables {{{
export LANG=ja_JP.UTF-8
export EDITOR=vim
export PAGER="less -cs"
export LESSCHARSET=utf-8
export JLESSCHARSET=utf-8
# }}}

## zshenv.local {{{
[ -f ~/.zshenv.local ] && source ~/.zshenv.local
# }}}


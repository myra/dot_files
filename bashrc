# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples
# attr{address}=="00:1a:70:11:73:0f"

# If not running interactively, don't do anything
#[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
#export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
# ... or force ignoredups and ignorespace
export HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend
# correct small spelling errors
shopt -s cdspell
shopt -s extglob

shopt -s cmdhist
shopt -s checkwinsize
# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.


##################################################
# Fancy PWD display function
##################################################
# The home directory (HOME) is replaced with a ~
# The last pwdmaxlen characters of the PWD are displayed
# Leading partial directory names are striped off
# /home/me/stuff          -> ~/stuff               if USER=me
# /usr/share/big_dir_name -> ../share/big_dir_name if pwdmaxlen=20
##################################################
bash_prompt_command() {
    # How many characters of the $PWD should be kept
    local pwdmaxlen=25
    # Indicate that there has been dir truncation
    local trunc_symbol=".."
    local dir=${PWD##*/}
    pwdmaxlen=$(( ( pwdmaxlen < ${#dir} ) ? ${#dir} : pwdmaxlen ))
    NEW_PWD=${PWD/#$HOME/\~}
    local pwdoffset=$(( ${#NEW_PWD} - pwdmaxlen ))
    if [ ${pwdoffset} -gt "0" ]
    then
        NEW_PWD=${NEW_PWD:$pwdoffset:$pwdmaxlen}
        NEW_PWD=${trunc_symbol}/${NEW_PWD#*/}
    fi
}

bash_prompt() {
    case $TERM in
     xterm*|terminator*)
         local TITLEBAR='\[\033]0;\u:${NEW_PWD}\007\]'
    #      ;;
    # *)
    #     local TITLEBAR=""
    #      ;;
    esac
    local NONE="\[\033[0m\]"    # unsets color to term's fg color

    # regular colors
    local K="\[\033[0;30m\]"    # black
    local R="\[\033[0;31m\]"    # red
    local G="\[\033[0;32m\]"    # green
    local Y="\[\033[0;33m\]"    # yellow
    local B="\[\033[0;34m\]"    # blue
    local M="\[\033[0;35m\]"    # magenta
    local C="\[\033[0;36m\]"    # cyan
    local W="\[\033[0;37m\]"    # white

    # emphasized (bolded) colors
    local EMK="\[\033[1;30m\]"
    local EMR="\[\033[1;31m\]"
    local EMG="\[\033[1;32m\]"
    local EMY="\[\033[1;33m\]"
    local EMB="\[\033[1;34m\]"
    local EMM="\[\033[1;35m\]"
    local EMC="\[\033[1;36m\]"
    local EMW="\[\033[1;37m\]"

    # background colors
    local BGK="\[\033[40m\]"
    local BGR="\[\033[41m\]"
    local BGG="\[\033[42m\]"
    local BGY="\[\033[43m\]"
    local BGB="\[\033[44m\]"
    local BGM="\[\033[45m\]"
    local BGC="\[\033[46m\]"
    local BGW="\[\033[47m\]"

    local UC=$EMG                 # user's color
    local RUC=$EMR
    local CUC=$EMK

    if [ "$PS1" ]; then
        if [ "$BASH" ]; then
            if [  "`id -u`" -ge 1000 ]; then
                        PS1="$TITLEBAR${EMY}[${UC}\u${EMY}@${EMY}\h ${EMG}\${NEW_PWD}${EMY}]${EMY}:${EMG}"      #user's colors
                elif [ "`id -u`" -lt 1000 ]; then
                    PS1="$TITLEBAR${EMR}[${RUC}\u${EMB}@${EMR}\h ${EMB}\${NEW_PWD}${EMR}]${EMK}::#${EMR}"    # root's colors
            elif [ -z "chroot" ]; then
                PS1="$CHROOT${EMW}[${CUC}\u${EMW}@${EMK}\h ${EMK}\${NEW_PWD}${EMW}]${EMY}::>${EMW}"      #chroot colors
                fi
        fi
    fi

    #PS1="$TITLEBAR${EMY}[${UC}\u${EMK}@${EMR}\h ${EMB}\${NEW_PWD}${EMY}]${EMG}: ${EMB}"
    # without colors: PS1="[\u@\h \${NEW_PWD}]\\$ "
    # extra backslash in front of \$ to make bash colorize the prompt
}

PROMPT_COMMAND=bash_prompt_command
bash_prompt
unset bash_prompt
###########################################################################

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

#if [ "$PS1" ]; then
#    mkdir -m 0700 /sys/fs/cgroup/cpu/user/$$
#    echo $$ > /sys/fs/cgroup/cpu/user/$$/tasks
#fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).

if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

extract() {
  local e=0 i c
  for i; do
    if [[ -r $i ]]; then
        c=''
        case $i in
          *.t@(gz|lz|xz|b@(2|z?(2))|a@(z|r?(.@(Z|bz?(2)|gz|lzma|xz)))))
                 c='bsdtar xvf' ;;
          *.7z)  c='7z x'       ;;
          *.Z)   c='uncompress' ;;
          *.bz2) c='bunzip2'    ;;
          *.exe) c='cabextract' ;;
          *.gz)  c='gunzip'     ;;
          *.rar) c='unrar x'    ;;
          *.xz)  c='unxz'       ;;
          *.zip) c='unzip'      ;;
          *)     echo "$0: cannot extract \`$i': Unrecognized file extension" >&2; e=1 ;;
        esac
        [[ $c ]] && command $c "$i"
    else
        echo "$0: cannot extract \`$i': File is unreadable" >&2; e=2
    fi
  done
  return $e
}

function cv () {
    cdargs "$1" && cd "`cat "$HOME/.cdargsresult"`" && pwd ;
}

    d=~/.config/myconfig/dircolors
    test -r $d && eval "$(dircolors $d)"


export MANPAGER="/usr/bin/most -s"

###########################################
export WINDOW_MANAGER="/usr/bin/openbox"
###########################################
export TERM="rxvt-unicode"
export LANG="en_US.UTF-8"
export EDITOR="gvim"
export LC_ALL=
export LC_COLLATE="C"
export NASMENV="-I/home/myra/bin/nasmx-1.0/inc"
#export GOPATH="~/go"
export GOROOT="/home/myra/go"
export GOARCH="amd64"
export GOOS="linux"
export GOBIN="/home/myra/go/bin" 

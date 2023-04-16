# some more aliases
# restart by source .bashrc or restart
# restart by . ~/.bash_aliases
## ls commands
alias ls='ls --color=auto'
alias ll='ls -alFh --color=auto'
alias la='ls -A'
alias l='ls -CF'
alias lsd='lsblk -o +MODEL,SERIAL'
#### Remvove the --icons if or install a Nerdfont
alias exa='exa --long --icons'
alias exat='exa --long --icons --tree '
## confirm before overwriting something
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
## Colorize grep output (good for log files)
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
## docker related
alias dcn='nano docker-compose.yml'
alias dcup='docker compose up -d'
alias dcupl='docker compose up -d && docker compose logs -f'
alias dcr='docker compose restart'
alias dcd='docker compose down'
## system related
alias bat='batcat'
#alias cat='batcat'
#alias catt='cat'
alias sr='sudo reboot'
alias bye='sudo poweroff'
alias update='sudo apt update'
alias upgrade='sudo apt upgrade'
alias upall='sudo apt update && sudo apt upgrade -y'
alias nhost='sudo nano /etc/hosts'
alias df='df -h'
alias free='free -m'
## cd aliases
alias 'cd..'='cd ..'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
## IP related
#### 192 for 192.168.1.0 - Use your subnet here
alias myip="echo My LAN-ip: $(ip address | grep 192 | awk '{print $2}')"
#alias lanip="ip a | grep inet | awk '{print $2}' | cut -f2 -d:"
#alias wanip='echo WanIp: $(curl ipinfo.io/ip)'
#alias netspeed='sudo curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python3 -'
# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
#alias sää='curl wttr.in'
#alias mikä='curl cheat.sh/'
# Extracting archive files
# # usage: ex <file>
ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1   ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *.deb)       ar x $1      ;;
      *.tar.xz)    tar xf $1    ;;
      *.tar.zst)   tar xf $1    ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

BRACKET_COLOR="\[\033[38;5;35m\]"
CLOCK_COLOR="\[\033[38;5;35m\]"
JOB_COLOR="\[\033[38;5;33m\]"
PATH_COLOR="\[\033[38;5;33m\]"
LINE_BOTTOM="\342\224\200"
LINE_BOTTOM_CORNER="\342\224\224"
LINE_COLOR="\[\033[38;5;248m\]"
LINE_STRAIGHT="\342\224\200"
LINE_UPPER_CORNER="\342\224\214"
END_CHARACTER="|"

tty -s && export PS1="$LINE_COLOR$LINE_UPPER_CORNER$LINE_STRAIGHT$LINE_STRAIGHT$BRACKET_COLOR[$CLOCK_COLOR\t$BRACKET_COLOR]$LINE_COLOR$LINE_STRAIGHT$BRACKET_COLOR[$JOB_COLOR\j$BRACKET_COLOR]$LINE_COLOR$LINE_STRAIGHT$BRACKET_COLOR[\H:\]$PATH_COLOR\w$BRACKET_COLOR]\n$LINE_COLOR$LINE_BOTTOM_CORNER$LINE_STRAIGHT$LINE_BOTTOM$END_CHARACTER\[$(tput sgr0)\] "

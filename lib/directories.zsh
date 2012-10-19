# Changing/making/removing directory
setopt auto_name_dirs
setopt auto_pushd
setopt pushd_ignore_dups

alias ..='cd ..'
alias cd..='cd ..'
alias cd...='cd ../..'
alias cd....='cd ../../..'
alias cd.....='cd ../../../..'
alias cd/='cd /'

alias 1='cd -'
alias 2='cd +2'
alias 3='cd +3'
alias 4='cd +4'
alias 5='cd +5'
alias 6='cd +6'
alias 7='cd +7'
alias 8='cd +8'
alias 9='cd +9'

export ENV="dev"
export MYSQL_HOME="/usr/local/mysql"
export WORKSPACE="$HOME/Documents/workspace"
export MY_SCRIPTS="$HOME/.oh-my-zsh/scripts"

alias llw="ll $WORKSPACE"
alias cds="cd $MY_SCRIPTS"
alias lls="ll -alF $MY_SCRIPTS"
alias sshKeys="cd ~/Documents/keys/ssh"

cd () {
  if   [[ "x$*" == "x..." ]]; then
    cd ../..
  elif [[ "x$*" == "x...." ]]; then
    cd ../../..
  elif [[ "x$*" == "x....." ]]; then
    cd ../../..
  elif [[ "x$*" == "x......" ]]; then
    cd ../../../..
  else
    builtin cd "$@"
  fi
}

cdw(){
  cd $WORKSPACE/$1;
}

alias md='mkdir -p'
alias rd=rmdir
alias d='dirs -v | head -10'

# mkdir & cd to it
function mcd() {
  mkdir -p "$1" && cd "$1";
}

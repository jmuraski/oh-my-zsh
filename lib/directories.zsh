# Changing/making/removing directory
setopt auto_name_dirs
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushdminus

alias ..='cd ..'
alias cd..='cd ..'
alias cd...='cd ../..'
alias cd....='cd ../../..'
alias cd.....='cd ../../../..'
alias cd/='cd /'

alias 1='cd -'
alias 2='cd -2'
alias 3='cd -3'
alias 4='cd -4'
alias 5='cd -5'
alias 6='cd -6'
alias 7='cd -7'
alias 8='cd -8'
alias 9='cd -9'

export ENV="dev"
export MYSQL_HOME="/usr/local/mysql"
export WORKSPACE="$HOME/Documents/workspace"
export MY_SCRIPTS="$HOME/.oh-my-zsh/scripts"
export HOMEBREW_HOME="/usr/local/Cellar"
export RIAK_HOME="$HOMEBREW_HOME/riak/1.2.1-x86_64"
export HBASE_HOME="$HOMEBREW_HOME/hbase/0.94.2"
export GRADLE_HOME="/usr/local/gradle-1.9"
export GROOVY_HOME="/usr/local/groovy-2.2.1"
export HOMEBREW_GITHUB_API_TOKEN="735a56b3d43f92cb78445c5fd9f7a76447df891e"
export ANDROID_HOME="/Users/jmuraski/Documents/android/adt-bundle-mac-x86_64-20140321/sdk"
export ANDROID_TOOLS="$ANDROID_HOME/platform-tools"
export EDITOR='vim'
export DOCKER_HOST=tcp://localhost:2375

alias startriak="$RIAK_HOME/bin/riak start"
alias stopriak="$RIAK_HOME/bin/riak stop"
alias starthbase="$HBASE_HOME/bin/start-hbase.sh"
alias starthbase="$HBASE_HOME/bin/stop-hbase.sh"

alias llw="ll $WORKSPACE"
alias cds="cd $MY_SCRIPTS"
alias lls="ll -alF $MY_SCRIPTS"
alias sshKeys="cd ~/Documents/keys/ssh"

notebook(){
  cd ~/Documents/Notebooks;
  if [[ "$1" == "save" ]]; then
    cd ~/Documents/Notebooks
    git add .
    git commit -m 'updating'
    git push   
  elif [[ "$1" == "load" ]]; then
    cd ~/Documents/Notebooks
    git pull
  else
    cd ~/Documents/Notebooks
  fi
}

cd () {
  if   [[ "x$*" == "x..." ]]; then
    cd ../..
  elif [[ "x$*" == "x...." ]]; then
    cd ../../..
  elif [[ "x$*" == "x....." ]]; then
    cd ../../../..
  elif [[ "x$*" == "x......" ]]; then
    cd ../../../../..
  elif [ -d ~/.autoenv ]; then
    source ~/.autoenv/activate.sh
    autoenv_cd "$@"
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

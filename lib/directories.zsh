# Changing/making/removing directory
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushdminus



export ENV="dev"
export MYSQL_HOME="/usr/local/mysql"
export WORKSPACE="$HOME/Documents/workspace"
export MY_SCRIPTS="$HOME/.oh-my-zsh/scripts"
export HOMEBREW_HOME="/usr/local/Cellar"
export RIAK_HOME="$HOMEBREW_HOME/riak/1.2.1-x86_64"
export HBASE_HOME="$HOMEBREW_HOME/hbase/0.94.2"
export GRADLE_HOME="/usr/local/gradle-1.9"
export GROOVY_HOME="/usr/local/groovy-2.2.1"
export HOMEBREW_GITHUB_API_TOKEN="1c44832086f692d84ed2d6369920f35ae7ede7fe"
export ANDROID_HOME="/Users/jmuraski/Documents/android/adt-bundle-mac-x86_64-20140321/sdk"
export ANDROID_TOOLS="$ANDROID_HOME/platform-tools"

alias llw="ll $WORKSPACE"
alias cds="cd $MY_SCRIPTS"

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

cdw(){
  cd $WORKSPACE/$1;
}
compctl -W $WORKSPACE/ -/ cdw

# mkdir & cd to it
function mcd() {
  mkdir -p "$1" && cd "$1";
}

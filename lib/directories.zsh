# Changing/making/removing directory
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushdminus


alias -- -='cd -'

export ENV="dev"
export MYSQL_HOME="/usr/local/mysql"
export WORKSPACE="$HOME/Documents/workspace"
export MY_SCRIPTS="$HOME/.oh-my-zsh/scripts"
export HOMEBREW_HOME="/usr/local/Cellar"
export RIAK_HOME="$HOMEBREW_HOME/riak/1.2.1-x86_64"
export HBASE_HOME="$HOMEBREW_HOME/hbase/0.94.2"
export GRADLE_HOME="$HOME/.sdkman/candidates/gradle/current"
export GROOVY_HOME="$HOME/.sdkman/candidates/groovy/current/"
export HOMEBREW_GITHUB_API_TOKEN="1c44832086f692d84ed2d6369920f35ae7ede7fe"
export ANDROID_HOME="/Users/jmuraski/Documents/android/adt-bundle-mac-x86_64-20140321/sdk"
export ANDROID_TOOLS="$ANDROID_HOME/platform-tools"
export GOPATH=$HOME/go
export GOBIN=$GOPATH/bin
export SHIPT_HOME='/Users/joemuraski/Documents/workspace/go/shipt/'
export PRIORITY_PATH=$HOME/.oh-my-zsh/priority_path

alias llw="ll $WORKSPACE"
alias cdscripts="cd $MY_SCRIPTS"

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

cds(){
  cd $SHIPT_HOME/$1;
}
compctl -W $SHIPT_HOME/ -/ cds

# mkdir & cd to it
function mcd() {
  mkdir -p "$1" && cd "$1";
}

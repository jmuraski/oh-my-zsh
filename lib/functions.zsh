function zsh_stats() {
  history | awk '{CMD[$2]++;count++;}END { for (a in CMD)print CMD[a] " " CMD[a]/count*100 "% " a;}' | grep -v "./" | column -c3 -s " " -t | sort -nr | nl |  head -n20
}

function uninstall_oh_my_zsh() {
  /usr/bin/env ZSH=$ZSH /bin/sh $ZSH/tools/uninstall.sh
}

function upgrade_oh_my_zsh() {
  /usr/bin/env ZSH=$ZSH /bin/sh $ZSH/tools/upgrade.sh
}

function take() {
  mkdir -p $1
  cd $1
}

function trash() {
  local trash_dir="${HOME}/.Trash"
  local temp_ifs=$IFS
  IFS=$'\n'
  for item in "$@"; do
    if [[ -e "$item" ]]; then
      item_name="$(basename $item)"
      if [[ -e "${trash_dir}/${item_name}" ]]; then
        mv -f "$item" "${trash_dir}/${item_name} $(date "+%H-%M-%S")"
      else
        mv -f "$item" "${trash_dir}/"
      fi
    fi
  done
  IFS=$temp_ifs
}

function featureBranch() {
  echo "git checkout -b jmuraski/feature/$1"
  git checkout -b jmuraski/feature/$1
  echo "git push --set-upstream  origin jmuraski/feature/$1"
  git push --set-upstream  origin jmuraski/feature/$1
}

function mergeMaster() {
  CURRENT_BRANCH=$(git branch | grep "*" | awk '{ print $2 }')
  echo "Current Branch is $CURRENT_BRANCH"
  echo "git checkout master"
  git checkout master
  echo "git pull"
  git pull
  echo "git checkout $CURRENT_BRANCH"
  git checkout $CURRENT_BRANCH
  echo "git merge master"
  git merge master
}

function removeBranch(){
  echo "git checkout master"
  git checkout master
  echo "git branch -d jmuraski/feature/$1"
  git branch -d jmuraski/feature/$1
  echo "git push origin :jmuraski/feature/$1"
  git push origin :jmuraski/feature/$1
}

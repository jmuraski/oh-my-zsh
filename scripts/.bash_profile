export GROOVY_HOME="/usr/local/groovy"
export GRAILS_HOME="/usr/local/grails"
export GRAILS_OPTS="-Xms2g -Xmx2g -XX:PermSize=1g -XX:MaxPermSize=1g -XX:NewRatio=3"
#export JAVA_HOME="/opt/java"
export M2_HOME=/usr/share/java/maven-2.2.1
export M2=$M2_HOME/bin
export ENV="dev"
export MYSQL_HOME="/usr/local/mysql"
export WORKSPACE="/Users/jmuraski/Documents/workspace"

export PATH="$PATH:$SCRIPTS"
export PATH="$PATH:$GROOVY_HOME/bin"
export PATH="$PATH:$GRAILS_HOME/bin"
#export PATH="$PATH:$JAVA_HOME/bin"
export PATH="$PATH:/usr/local/bin"
export PATH="$PATH:$M2"
export PATH="$PATH:$MYSQL_HOME/bin"
export EDITOR="vi"

alias ll='ls -alF'
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias hgcom="hg com --subrepos -v -m"
#alias hgclose="hg com -v --close-branch -m "
alias hglog="hg log -r 0:tip"
alias hgchanges="hg stat -S --change "

alias hgs="hg status -S"
alias hga="hg add -S"
alias hgo="hg outgoing -S"
alias hgi="hg incoming -S"
alias hgd="hg diff -S"
alias hgf="hg fetch"
alias hgof="hg outgoing -S -v | lf"
alias hgif="hg incoming -S -v | lf"

alias run="grails run-app"
alias test="grails test-app"
alias unit="grails test-app unit:"
alias integration="grails test-app integration:"
alias functional="grails test-app -onlyFunctional"
alias llw="ll $WORKSPACE"
alias reload="source ~/.profile"
alias editprofile="mate ~/.profile"
alias cds="cd $SCRIPTS"
alias lls="ll -alF $SCRIPTS"
alias sshKeys="cd ~/Documents/keys/ssh"

alias startbMySql='sudo -b $MYSQL_HOME/bin/mysqld_safe'
alias startMySql='sudo $MYSQL_HOME/bin/mysqld_safe'
alias stopMySql='$MYSQL_HOME/bin/mysqladmin shutdown -uroot -p'
alias h='history'
alias runFitness='grails test-app --onlyFitnesse integration:fitnesse "FitNesse.BloomTestSuite?suite"'

alias bhredis=' redis-server ~/Documents/workspace/bloomhealth/bloomhealth/redis/redis.conf'
alias rabbit='rabbitmq-server'

alias bloomhealth='cd ~/Documents/workspace/bloomhealth/bloomhealth'
alias bhbo='cd ~/Documents/workspace/bhbo/bhbo'
alias common='cd ~/Documents/workspace/bloom-common'
alias domain="cd ~/Documents/workspace/bloom-domain" 

#alias startTomcat='/opt/tomcat/bin/startup.sh && tail -f /opt/tomcat/logs/catalina.out'

#Bloom aliases Settings

#symlink to bloomhealth-config.groovy - dev & sanitized prod
alias lns='rm ~/.grails/bloomhealth-config.groovy; ln -s /Volumes/TRUECRYPT/bloomhealth-config.groovy.staging /Users/jmuraski/.grails/bloomhealth-config.groovy && ls -la ~/.grails/bloomhealth-config.groovy'
alias lnd='rm ~/.grails/bloomhealth-config.groovy; ln -s /Users/jmuraski/Documents/workspace/bloomhealth/bloom_config/Dev/bloomhealth-config.groovy /Users/jmuraski/.grails/bloomhealth-config.groovy && ls -la ~/.grails/bloomhealth-config.groovy'

#Standard Funtions
cdw(){
	cd $WORKSPACE/$1;
}

lf () {
       grep files | awk '{for (i=2; i<=NF; i++)  print $i }' | sort | uniq
}

startUp(){
	cd $SCRIPTS
	sudo -b $MYSQL_HOME/bin/mysqld_safe
	tcmd rabbitmq-server
	tcmd redis-server ~/Documents/workspace/bloomhealth/bloomhealth/redis/redis.conf
}

hgtarget() {
    hg_root=`hg root 2>&1 | egrep -v "$abort:"`
   	if [ $hg_root ]; then
    	if [ -f $hg_root/.hg/hgrc ]; then
        	hg_target=`cat $hg_root/.hg/hgrc | egrep "^default =" | sed 's/\(^default = \(http:\/\/\)*\)\(.*@\)*//'`
        	echo "$hg_target"
        fi
    fi
}

hgbranch() {
	hg_root=`hg root 2>&1 | egrep -v "$abort:"`
	if [ $hg_root ]; then
		hg_branch=`hg branch`
		echo
		echo -n "Branch:$hg_branch"
	fi
}

hgbookmark() {
	hg_root=`hg root 2>&1 | egrep -v "$abort:"`
	if [ $hg_root ]; then
		hg_bookmark=`hg bookmark | grep '*' | awk '{print $2'}`
		if [ -n "$hg_bookmark" ]; then 
			echo -n " - Bookmark:$hg_bookmark"
		fi
	fi
}

hg_dirty() {
	hg_root=`hg root 2>&1 | egrep -v "$abort:"`
	if [ $hg_root ]; then
		hg_status=`hg stat | awk '{print $1'}`
		echo "$hg_status"
    fi
}

function del ()
{
  if declare -F trash >/dev/null
  then
    trash "$@"
  else
    command rm -i "$@"
  fi
}

function trash ()
{
  local F
  local HOME_DEVICE="$(stat -f %Sd "$HOME")"
  local TRASHCAN=~/.Trash
    # Set this in advance _outside_ the loop below
  for F in "$@"
  do
    if ! test -e "$F"
    then
      echo "No such file or directory: $F" 1>&2
      return 4
    fi
    
    local DEVICE="$(stat -f %Sd "$F")"
    
    if [ x"$DEVICE" == x"" ] || [ x"$DEVICE" == x"???" ]
    then
      echo "Can't locate trash for ${F}." 1>&2
      return 3
    fi
    
    if [ x"$DEVICE" != x"$HOME_DEVICE" ]
    then
      TRASHCAN="$(trashOnDevice "$DEVICE")"
    fi
    
    if [ ! -d "${TRASHCAN}" ]
    then
      command rm -f "${TRASHCAN}"
      if ! mkdir -m 700 "${TRASHCAN}"
      then
        echo "$TRASHCAN is inaccessible at this time." | sed 's;'"$HOME"';~;g' 1>&2
        return 1
      fi
    fi
    
    local FinT="$(basename "$F")"
    
    if [ -e "${TRASHCAN}/${FinT}" ]
    then
      FinT="$(date) ${FinT}"
    fi
    
    if ! mv -vn "$F" "${TRASHCAN}/${FinT}"
    then
      echo "Unable to move $F to the trash. trying Sudo" 1>&2
      if ! sudo mv -vn "$F" "${TRASHCAN}/${FinT}"
      then
      	echo "Unable to move $F to the trash. trying" 1>&2
	    return 2
      fi
	fi
  done
  
  local TRASHSIZE="$(du -hs "${TRASHCAN}" 2>/dev/null | cut -f 1)"
  local TRASHCANloc="$(dirname "$TRASHCAN" | sed 's;^/Volumes/\(.*\)/.Trashes;\1;g' | sed 's;'"$HOME"';~;g' | sed 's;^/.Trashes;/;g')"
  echo "${TRASHSIZE:-  0B} in trash on $TRASHCANloc."
}

function emptytrash ()
{
  local TMPIFS="$IFS"
  IFS='
'
  local MOUNTS=( $(mount | sed -n 's:/dev/.* on \(.*\) (.*):\1:p') )
  local TRASHCANs=( "${HOME}/.Trash" $(IFS="$TMPIFS";for i in `seq 0 $(( ${#MOUNTS[@]} - 1 ))`; do echo "${MOUNTS[$i]}/.Trashes/$(id -u)"; done) )
  IFS="$TMPIFS"
  unset TMPIFS

  local TRASH_SIZE
  TRASH_SIZE="$( (for i in "${TRASHCANs[@]}"; do ls "$i"/; done) 2>/dev/null | wc -w)"
  if [ "$TRASH_SIZE" -gt 0 ]
  then 
    echo -n "Emptying trash"
    for i in "${TRASHCANs[@]}"
    do 
      tput smcup
      pushd "$i" 2>/dev/null && {
        srm -frsvz . 2>/dev/null ; popd ;
      }
      tput rmcup
      echo -n .
    done
    local DONE=
    [ `ls "${HOME}/.Trash" | wc -w` == 0 ] && DONE="Done."
    echo "$DONE"
  else 
    echo "Trash is empty."
  fi
}

function trashOnDevice ()
{
  local DEVICE="$1"
  local MOUNT="$(mount | sed -n 's:/dev/'"$DEVICE"' on \(.*\) (.*):\1:p')"
  
  if [ x"$MOUNT" == x"" ] || [ x"$MOUNT" == x"???" ]
  then
    # If no mount point is found, then don't return the path to root!
    return 1
  elif [ x"$MOUNT" == x"/" ]
  then
    # Encourage the resulting path to _not_ start with two slashes
    MOUNT=""
  fi
  
  echo "$MOUNT/.Trashes/$UID"
}

# Usage : seq n m [i]
# echo all integers between n and m using a skip or increment of i
function seq ()
{
  [ "$1" ] || [ "$2" ] || return 1
  
  local x=$1;
  local y=$2;
  local i=${3:-1};
  local seperator="${4:- }"
  while [ $x -le $y ]
  do
    echo -n $x"${seperator}";
    x=$(( $x + $i ));
  done
  echo
}

PROMPT="
%n at %m in %d$(hgbranch)
$ "

##
# Your previous /Users/jmuraski/.bash_profile file was backed up as /Users/jmuraski/.bash_profile.macports-saved_2010-08-20_at_21:26:38
##

# MacPorts Installer addition on 2010-08-20_at_21:26:38: adding an appropriate PATH variable for use with MacPorts.
export PATH=/opt/local/bin:/opt/local/sbin:/usr/local/sbin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.
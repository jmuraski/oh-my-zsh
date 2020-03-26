export WORKSPACE="$HOME/Documents/workspace"
# Push and pop directories on directory stack
alias pu='pushd'
alias po='popd'

# Basic directory operations
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias -- -='cd -'

# Super user
alias _='sudo'
alias please='sudo'

#alias g='grep -in'

# Show history
if [ "$HIST_STAMPS" = "mm/dd/yyyy" ]
then
    alias history='fc -fl 1'
elif [ "$HIST_STAMPS" = "dd.mm.yyyy" ]
then
    alias history='fc -El 1'
elif [ "$HIST_STAMPS" = "yyyy-mm-dd" ]
then
    alias history='fc -il 1'
else
    alias history='fc -l 1'
fi
# List direcory contents
alias lsa='ls -lah'
alias ll='ls -alF'
alias l='ls -lah'
alias la='ls -lAh'
alias sl=ls # often screw this up
alias llg='ls -alF | grep '

alias md='mkdir -p'
alias rd=rmdir
alias d='dirs -v | head -10'
alias afind='ack-grep -il'
alias lls="ll -alF $MY_SCRIPTS"
alias sshKeys="cd ~/Documents/keys/ssh"
alias reload="source ~/.zshrc"
alias editprofile="atom ~/.zshrc"
alias vimprofile="vim ~/.zshrc"
alias editalias="atom ~/.oh-my-zsh/lib/aliases.zsh"
alias vimalias="vim ~/.oh-my-zsh/lib/aliases.zsh"
alias edithosts="atom /private/etc/hosts"
alias vimhosts="vim /private/etc/hosts"
alias listhosts="cat /private/etc/hosts"
alias editfunctions="atom ~/.oh-my-zsh/lib/functions.zsh"
alias vimfunctions="vim ~/.oh-my-zsh/lib/functions.zsh"
alias editdirs="atom ~/.oh-my-zsh/lib/directories.zsh"
alias vimdirs="vim ~/.oh-my-zsh/lib/directories.zsh"
alias editssh='atom ~/.ssh/config'
alias vimssh='vim ~/.ssh/config'
alias editenv='atom ~/.oh-my-zsh/custom/env.zsh'
alias vienv='vim ~/.oh-my-zsh/custom/env.zsh'
alias vi='vim'
alias exip='dig +short myip.opendns.com @resolver1.opendns.com'
alias inip='ipconfig getifaddr en0'
alias shipit='open $WORKSPACE/shipit'
alias h="history"

alias startpostgres='pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start'
alias stoppostgres='pg_ctl -D /usr/local/var/postgres stop -s -m fast'
alias startTomcat7='/usr/local/apache-tomcat-7.0.37/bin/startup.sh'
alias tomcat7Start='/usr/local/apache-tomcat-7.0.37/bin/startup.sh'
alias shutdownTomcat7='/usr/local/apache-tomcat-7.0.37/bin/shutdown.sh'
alias tomcat7Shutdown='/usr/local/apache-tomcat-7.0.37/bin/shutdown.sh'
alias tailTomcat='tail -f /usr/local/apache-tomcat-7.0.37/logs/catalina.out'

alias startmongo='/usr/local/Cellar/mongodb/2.4.9/mongod run --rest'
# export CC=gcc

# Manta Aliases
alias start1='~/Documents/Virtual\ Machines.localized/startUbuntu.sh'
alias con1="ssh jmuraski@192.168.163.100"


# Remote Insights Aliases
alias startRedis='redis-server /usr/local/etc/redis.conf'


# Fleet Commands
alias fl='fleetctl '
alias fld='fleetctl destroy '
alias flm='fleetctl list-machines'
alias flst='fleetctl start '
alias fls='fleetctl start '
alias flsto='fleetctl stop '
alias flop='fleetctl stop '
alias flu='fleetctl list-units'
alias flub='fleetctl submit '
alias fluf='fleetctl list-unit-files'
alias flssh='fleetctl ssh '
alias flstat='fleetctl status '
alias flat='fleetctl status '
alias fload='fleetctl load '
alias flog='fleetctl journal '
alias flogs='fleetctl journal -f '
alias npmr='npm run '

alias dm='docker-machine'

alias git-prune='git remote prune origin'
alias git-publish='git push -u origin HEAD'

alias isodateutc='date -u +"%Y-%m-%dT%H:%M:%SZ"'
alias isodate='date +"%Y-%m-%dT%H:%M:%SZ"'

alias sauce-connect="/usr/local/Sauce-Connect/open"
alias chromeInsecure="open -a Google\ Chrome --args --disable-web-security"
alias marked="open -a Marked\ 2 "

export NOTES="$WORKSPACE/notes"
export WIKI="$NOTES/wiki"
alias notes="atom -n $NOTES; atom -n $WIKI/home.md"

alias -s log="less -MN"
alias -s txt="less -MN"
alias -s md="open -a Marked\ 2"
alias -g G='| grep'
alias rvmLoad='rvm .rvmrc'

alias ...='../..'
alias ....='../../..'
alias .....='../../../..'
alias ......='../../../../..'

alias 1='cd -'
alias 2='cd -2'
alias 3='cd -3'
alias 4='cd -4'
alias 5='cd -5'
alias 6='cd -6'
alias 7='cd -7'
alias 8='cd -8'
alias 9='cd -9'

alias drone='open https://drone6.target.com/Distribution-3D/'
alias jira='open "https://jira.target.com/secure/RapidBoard.jspa?rapidView=5437&selectedIssue=OB3D-18&quickFilter=25296"'
alias op='lsof -nP | grep -i listen'
alias opc='netstat -anvp tcp | grep -i listen'

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

alias afind='ack-grep -il'

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
alias vi='vim'
alias exip='dig +short myip.opendns.com @resolver1.opendns.com'
alias inip='ipconfig getifaddr en0'

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
alias github-bully='open https://github.com/jmuraski/mean_playground_bully'


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

# Best Buy Aliases
#alias ssh-ca-dev30='ssh -v -i ~/.ssh/keys/ca-ssh-keypair.pem ec2-user@ec2-54-245-110-30.us-west-2.compute.amazonaws.com'
#alias ssh-ca-dev-tomcat='ssh -v -i ~/.ssh/keys/ca-ssh-keypair.pem ec2-user@ec2-54-245-110-30.us-west-2.compute.amazonaws.com'
#alias ssh-ca-dev32='ssh -v -i ~/.ssh/keys/ca-ssh-keypair.pem ec2-user@ec2-54-245-110-32.us-west-2.compute.amazonaws.com'
#alias ssh-ca-dev-apache='ssh -v -i ~/.ssh/keys/ca-ssh-keypair.pem ec2-user@ec2-54-245-110-32.us-west-2.compute.amazonaws.com'
#alias ssh-ca-uat40='ssh -v -i ~/.ssh/keys/ca-ssh-keypair.pem ec2-user@ec2-54-214-28-40.us-west-2.compute.amazonaws.com'
#alias ssh-ca-uat-tomcat='ssh -v -i ~/.ssh/keys/ca-ssh-keypair.pem ec2-user@ec2-54-214-28-40.us-west-2.compute.amazonaws.com'
#alias ssh-ca-uat35='ssh -v -i ~/.ssh/keys/ca-ssh-keypair.pem ec2-user@ec2-54-214-28-35.us-west-2.compute.amazonaws.com'
#alias ssh-ca-uat-apache='ssh -v -i ~/.ssh/keys/ca-ssh-keypair.pem ec2-user@ec2-54-214-28-35.us-west-2.compute.amazonaws.com'
#alias ssh-jenkins='ssh -v -i ~/.ssh/keys/jenkins-ssh-keypair.pem ec2-user@54.245.238.194'
#alias bounceCommerceUi='curl --user admin:admin "http://localhost:8080/manager/text/reload?path=/commerceui"'
#alias github-fe='open https://github.com/bestbuyremix/commerce_anywhere_fe'
#alias github-rest='open https://github.com/bestbuyremix/commerce_ui'
#alias github-partner='open https://github.com/bestbuyremix/commerce_anywhere_partner'
#alias github-sim='open https://github.com/bestbuyremix/commerce_anywhere_sim'
#alias jira='open "https://bbyopen.jira.com/secure/RapidBoard.jspa?rapidView=35"'
#alias jenkins='open "http://54.245.238.194/"'
#alias artifactory='open "https://code.bestbuy.com/artifactory/"'

#Dev Jam Aliases
alias ssh-devjam-ci='ssh root@192.241.248.176'
alias ssh-devjam-docker='ssh root@107.170.22.200'
alias jenkins-devjam='open "http://192.241.248.176:8090/"'
alias github-tcfm='open https://github.com/DevJams/tcf_mobile'
alias github-tcfs='open https://github.com/DevJams/tcf_simulator'
alias github-zeoui='open https://github.com/DevJams/zeo_ui'
alias github-zeos='open https://github.com/DevJams/zeo_server'
alias ports-devjam="ssh root@107.170.22.200 docker ps | grep -o 'app.*' | sed -e 's/\(app\/[a-z,A-Z,_,0-9]*\).*\(0.0.0.0\)/\1 \2/' | awk '{print \$1 \" - \" \$2}'"
alias versionOne='open "https://www3.v1host.com/partner_DevJam/TeamRoom.mvc/Show/1762"'


#Remote Insights Aliases
alias github-ri-front='open https://github.com/RemoteInsights/ri_frontend'
alias github-ri-back='open https://github.com/RemoteInsights/ri_backend'
alias github-ri-web='open https://github.com/RemoteInsights/webapp'
alias github-ri-sim='open https://github.com/RemoteInsights/Simulator'

alias sauce-connect="/usr/local/Sauce-Connect/open"
alias chromeInsecure="open -a Google\ Chrome --args --disable-web-security"

alias -s log="less -MN"
alias -s txt="less -MN"
alias -g G='| grep'
alias rvmLoad='rvm .rvmrc'

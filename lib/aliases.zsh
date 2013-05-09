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
alias history='fc -l 1'

# List direcory contents
alias lsa='ls -lah'
alias ll='ls -alF'
alias l='ls -lA1'
alias la='ls -lA'
alias sl=ls # often screw this up
alias llg='ls -alF | grep '

alias afind='ack-grep -il'

alias reload="source ~/.zshrc"
alias editprofile="subl ~/.zshrc"
alias vimprofile="vim ~/.zshrc"
alias editalias="subl ~/.oh-my-zsh/lib/aliases.zsh"
alias vimalias="vim ~/.oh-my-zsh/lib/aliases.zsh"
alias editfunctions="subl ~/.oh-my-zsh/lib/functions.zsh"
alias vimfunctions="vim ~/.oh-my-zsh/lib/functions.zsh"
alias editdirs="subl ~/.oh-my-zsh/lib/directories.zsh"
alias vimdirs="vim ~/.oh-my-zsh/lib/directories.zsh"
alias vi='vim'

alias startpostgres='pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start'
alias stoppostgres='pg_ctl -D /usr/local/var/postgres stop -s -m fast'
alias startTomcat7='/usr/local/apache-tomcat-7.0.37/bin/startup.sh'
alias tomcat7Start='/usr/local/apache-tomcat-7.0.37/bin/startup.sh'
alias shutdownTomcat7='/usr/local/apache-tomcat-7.0.37/bin/shutdown.sh'
alias tomcat7Shutdown='/usr/local/apache-tomcat-7.0.37/bin/shutdown.sh'
alias tailTomcat='tail -f /usr/local/apache-tomcat-7.0.37/logs/catalina.out'

alias startmongo='/usr/local/Cellar/mongodb/2.2.1-x86_64/mongod run --rest'
# export CC=gcc

alias start1='~/Documents/Virtual\ Machines.localized/startUbuntu.sh'
alias con1="ssh jmuraski@192.168.163.100"
alias ssh-ca-dev30='ssh -v -i ~/.ssh/keys/ca-ssh-keypair.pem ec2-user@ec2-54-245-110-30.us-west-2.compute.amazonaws.com'
alias ssh-ca-dev-tomcat='ssh -v -i ~/.ssh/keys/ca-ssh-keypair.pem ec2-user@ec2-54-245-110-30.us-west-2.compute.amazonaws.com'
alias ssh-ca-dev32='ssh -v -i ~/.ssh/keys/ca-ssh-keypair.pem ec2-user@ec2-54-245-110-32.us-west-2.compute.amazonaws.com'
alias ssh-ca-dev-apache='ssh -v -i ~/.ssh/keys/ca-ssh-keypair.pem ec2-user@ec2-54-245-110-32.us-west-2.compute.amazonaws.com'
alias ssh-jenkins='ssh -v -i ~/.ssh/keys/jenkins-ssh-keypair.pem ec2-user@54.245.238.194'

alias bounceCommerceUi='curl --user admin:admin "http://localhost:8080/manager/text/reload?path=/commerceui"'
alias github-fe='open https://github.com/bestbuyremix/commerce_anywhere_fe'
alias github-rest='open https://github.com/bestbuyremix/commerce_ui'

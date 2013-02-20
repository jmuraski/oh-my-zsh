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
alias editalias="subl ~/.oh-my-zsh/lib/aliases.zsh"
alias editfunctions="subl ~/.oh-my-zsh/lib/functions.zsh"
alias editdirs="subl ~/.oh-my-zsh/lib/directories.zsh"

alias startpostgres='pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start'
alias stoppostgres='pg_ctl -D /usr/local/var/postgres stop -s -m fast'

alias startmongo='/usr/local/Cellar/mongodb/2.2.1-x86_64/mongod run --rest'
# export CC=gcc

alias start1='~/Documents/Virtual\ Machines.localized/startUbuntu.sh'
alias con1="ssh jmuraski@192.168.163.100"
alias ssh-ca-dev1='ssh -v -i ~/.ssh/keys/ca-ssh-keypair.pem ec2-user@ec2-54-245-110-30.us-west-2.compute.amazonaws.com'
alias ssh-ca-dev2='ssh -v -i ~/.ssh/keys/ca-ssh-keypair.pem ec2-user@ec2-54-245-110-32.us-west-2.compute.amazonaws.com'
alias ssh-jenkins='ssh -v -i ~/.ssh/keys/jenkins-ssh-keypair.pem ec2-user@54.245.238.194'

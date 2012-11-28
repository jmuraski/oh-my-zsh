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

#alias g='grep -in'

# Show history
alias history='fc -l 1'

# List direcory contents
alias lsa='ls -lah'
alias l='ls -la'
alias ll='ls -alF'
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

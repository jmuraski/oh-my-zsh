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
alias editprofile="code ~/.zshrc"
alias vimprofile="vim ~/.zshrc"
alias editalias="code ~/.oh-my-zsh/lib/aliases.zsh"
alias vimalias="vim ~/.oh-my-zsh/lib/aliases.zsh"
alias edithosts="code /private/etc/hosts"
alias vimhosts="vim /private/etc/hosts"
alias listhosts="cat /private/etc/hosts"
alias editfunctions="code ~/.oh-my-zsh/lib/functions.zsh"
alias vimfunctions="vim ~/.oh-my-zsh/lib/functions.zsh"
alias editdirs="code ~/.oh-my-zsh/lib/directories.zsh"
alias vimdirs="vim ~/.oh-my-zsh/lib/directories.zsh"
alias editssh='code ~/.ssh/config'
alias vimssh='vim ~/.ssh/config'
alias editenv='code ~/.oh-my-zsh/custom/env.zsh'
alias vienv='vim ~/.oh-my-zsh/custom/env.zsh'
alias editspoons='code ~/.hammerspoon/hammerspoon.code-workspace'
alias editdash='code ~/.oh-my-zsh/scripts/dashboards'
alias vidash='vim code ~/.oh-my-zsh/scripts/dashboards'
alias goplay='code /Users/joemuraski/go/src/github.com/jmuraski/playground/playground.code-workspace'
alias vi='vim'
alias exip='dig +short myip.opendns.com @resolver1.opendns.com'
alias inip='ipconfig getifaddr en0'
alias shipit='open $WORKSPACE/shipit'
alias h="history"
alias compose="docker-compose"


# Fleet Commands
alias npmr='npm run '

alias git-prune='git remote prune origin'
alias git-publish='git push -u origin HEAD'

alias isodateutc='date -u +"%Y-%m-%dT%H:%M:%SZ"'
alias isodate='date +"%Y-%m-%dT%H:%M:%SZ"'

alias chromeInsecure="open -a Google\ Chrome --args --disable-web-security"
alias marked="open -a Marked\ 2 "

export NOTES="$WORKSPACE/notes"
export WIKI="$WORKSPACE/wiki"
alias notes="code $NOTES/notes.code-workspace"
alias wiki="code $WIKI/wiki.code-workspace;"
alias journal="code $WIKI/journal-2021.md"
alias -s log="less -MN"
alias -s txt="less -MN"
alias -s md="open -a Marked\ 2"
alias -g G='| grep'
alias rvmLoad='rvm .rvmrc'

# Aliases to Parse Hal Diangosis File
alias -g OL="| jq --unbuffered '. | {id: .OrderId,  platform_order: .PlatformOrder, created_at: .CreatedAt, status: .OrderlinesCount.status, og_lines: .OrderlinesCount.og_line_list_count, os_count: .OrderlinesCount.os_line_count}' | jq --unbuffered 'select(.status==\"red\") | .'"
alias -g AC="| jq --unbuffered '. | {id: .OrderId,  platform_order: .PlatformOrder, created_at: .CreatedAt, status: .OrderlinesCheck.status, invalid_lines: .OrderlinesCheck.invalid_order_lines, total_lines: .OrderlinesCheck.order_lines}' | jq --unbuffered 'select(.status==\"red\") | .'"
alias -g ST="| jq --unbuffered '. | {id: .OrderId,  platform_order: .PlatformOrder, created_at: .CreatedAt, status: .StatusCheck.status, og_status: .StatusCheck.og_order_status, os_status: .StatusCheck.order_service_order_status, av_status: .StatusCheck.redis_order_status}' | jq --unbuffered 'select(.status==\"red\") | .'"

# Aliases to Parse DLQ Responses
alias -g PMEM="| jq ' . | {order_id: .data.order.id, status: .data.order.status, message_type: .message_type, message_id: .message_id, sent_at: .message_sent_at}'"
alias -g PSHOP="| jq ' . | {order_id: .data.order_id, status: .data.status, message_type: .message_type, message_id: .message_id}'"

# Some shortcuts used alot
alias -g JID="| jq '. | .id' -c | tr -d '\"'"
alias -g TRQ="| tr -d '\"'"

alias 1='cd -'
alias 2='cd -2'
alias 3='cd -3'
alias 4='cd -4'
alias 5='cd -5'
alias 6='cd -6'
alias 7='cd -7'
alias 8='cd -8'
alias 9='cd -9'

alias op='lsof -nP | grep -i listen'
alias opc='netstat -anvp tcp | grep -i listen'
alias resolve='cd $(pwd -P)'
alias gps='gopass show'
alias rolldash='open "https://rollbar.com/ShiptLLC/?sort=total&environments=production&levels=30&levels=40&levels=50&duration=7d&tz=US%2FCentral&projects=189272&projects=258178&projects=277537&from=2020-11-14T09%3A00%3A00-06%3A00&to=2020-11-16T09%3A41%3A39-06%3A00&order=desc"'
alias kubedashian='open "https://kubedashian.shipt.com/"'

alias ts='date +%s'
alias cts='date -r'

alias avmon="aws-okta exec shipt-prod -- python3 /Users/joemuraski/Documents/workspace/go/shipt/shipt-aviator/scripts/avmonitor.py"
function box_name {
    [ -f ~/.box-name ] && cat ~/.box-name || hostname -s
}

PROMPT='%{$fg[magenta]%}%n%{$reset_color%} at %{$fg[yellow]%}$(box_name)%{$reset_color%} in %{$fg_bold[green]%}${PWD/#$HOME/~} %{$reset_color%} $(git_prompt_info)%{$fg_bold[blue]%} % %{$reset_color%}
%% '

ZSH_THEME_GIT_PROMPT_PREFIX="git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"


##
# Prompt
##
# setopt PROMPT_SUBST     # allow funky stuff in prompt
# color="blue"
# if [ "$USER" = "root" ]; then
#     color="red"         # root is red, user is blue
# fi;
# prompt="%{$fg[$color]%}%n%{$reset_color%}@%U%{$fg[yellow]%}%m%{$reset_color%}%u %T %B%~%b "
# RPROMPT='${vim_mode} ${vcs_info_msg_0_}'

# bindkey -v      # vi mode
# vim_ins_mode="%{$fg[yellow]%}[INS]%{$reset_color%}"
# vim_cmd_mode="%{$fg[cyan]%}[CMD]%{$reset_color%}"
# vim_mode=$vim_ins_mode

# function zle-keymap-select {
#     vim_mode="${${KEYMAP/vicmd/${vim_cmd_mode}}/(main|viins)/${vim_ins_mode}}"
#     zle reset-prompt
# }
# zle -N zle-keymap-select
#
# function zle-line-finish {
#     vim_mode=$vim_ins_mode
# }
# zle -N zle-line-finish

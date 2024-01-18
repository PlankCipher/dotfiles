setopt prompt_subst

autoload -U add-zsh-hook
autoload -Uz vcs_info

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*:prompt:*' check-for-changes true

PR_RST="%f"

FMT_UNSTAGED="%{$fg[blue]%}󰑊${PR_RST}"
FMT_STAGED="%{$fg[green]%}󰑊${PR_RST}"
FMT_BRANCH="%{$fg[magenta]%}%b %u%c${PR_RST}"
FMT_ACTION="%{$fg[yellow]%}(%{$fg[blue]%}%a%{$fg[yellow]%})${PR_RST}"

zstyle ':vcs_info:*:prompt:*' unstagedstr   "${FMT_UNSTAGED}"
zstyle ':vcs_info:*:prompt:*' stagedstr     "${FMT_STAGED}"
zstyle ':vcs_info:*:prompt:*' nvcsformats   ""

function steeef_precmd {
  OUT_OF_SYNC_WITH_REMOTE="%{$fg[red]%}$((git branch -v 2> /dev/null | grep -E 'ahead|behind' > /dev/null) && echo '  ')${PR_RST}"
  UNTRACKED="%{$fg[red]%}$((git status -s 2> /dev/null | grep '??' > /dev/null) && echo '󰑊')${PR_RST}"

  VCS_INFO="%{$fg[yellow]%}(${OUT_OF_SYNC_WITH_REMOTE}${FMT_BRANCH}${UNTRACKED}%{$fg[yellow]%})${PR_RST}"

  zstyle ':vcs_info:*:prompt:*' formats "${VCS_INFO} "
  zstyle ':vcs_info:*:prompt:*' actionformats "${VCS_INFO} ${FMT_ACTION} "

  vcs_info 'prompt'

  ((STEEEF_COMMAND_START > -1)) &&
    STEEEF_COMMAND_DURATION=$((SECONDS - STEEEF_COMMAND_START)) ||
    STEEEF_COMMAND_DURATION=0
  STEEEF_COMMAND_START=-1
}
add-zsh-hook precmd steeef_precmd

function steeef_preexec {
  STEEEF_COMMAND_START=$SECONDS
}
add-zsh-hook preexec steeef_preexec

function last_command_duration {
  DURATION_DAYS=$((STEEEF_COMMAND_DURATION / (60 * 60 * 24)))
  STEEEF_COMMAND_DURATION=$((STEEEF_COMMAND_DURATION % (60 * 60 * 24)))

  DURATION_HRS=$((STEEEF_COMMAND_DURATION / (60 * 60)))
  STEEEF_COMMAND_DURATION=$((STEEEF_COMMAND_DURATION % (60 * 60)))

  DURATION_MINS=$((STEEEF_COMMAND_DURATION / (60)))
  STEEEF_COMMAND_DURATION=$((STEEEF_COMMAND_DURATION % (60)))

  DURATION_SECS=$STEEEF_COMMAND_DURATION

  COMMAND_DURATION_MSG=''
  ((DURATION_DAYS > 0)) && COMMAND_DURATION_MSG+="${DURATION_DAYS}d "
  ((DURATION_HRS > 0)) && COMMAND_DURATION_MSG+="${DURATION_HRS}h "
  ((DURATION_MINS > 0)) && COMMAND_DURATION_MSG+="${DURATION_MINS}m "
  COMMAND_DURATION_MSG+="${DURATION_SECS}s"

  echo "%{$fg[yellow]%}(%{$fg[blue]%}took $COMMAND_DURATION_MSG%{$fg[yellow]%})"
}

export VIRTUAL_ENV_DISABLE_PROMPT=1
function virtualenv_info {
  [ $VIRTUAL_ENV ] && echo "%{$fg[yellow]%}(%{$fg[green]%}venv: $(basename $VIRTUAL_ENV)%{$fg[yellow]%})${PR_RST} "
}

PROMPT='%{$fg[yellow]%}┏━'
PROMPT+='%{$fg[red]%}$(echo "$? " | sed "s/^0 $//")'
PROMPT+='%{$fg[yellow]%}(%{$fg[blue]%}%n%{$fg[yellow]%}@%{$fg[blue]%}%m%{$fg[yellow]%}) '
PROMPT+='[%{$fg[cyan]%}%~%{$fg[yellow]%}] '
PROMPT+='$(((echo $vcs_info_msg_0_ | grep "󰑊" > /dev/null) && echo $vcs_info_msg_0_) || (echo $vcs_info_msg_0_ | sed -E "s/([^][^ ]) (%.*})\)/\1\2)/"))'
PROMPT+='$(virtualenv_info)'
PROMPT+='$(last_command_duration)'
PROMPT+=$'\n'
PROMPT+='%{$fg[yellow]%}┗━$ ${PR_RST}'

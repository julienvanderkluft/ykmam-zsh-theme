# Clean, simple, compatible and meaningful.
# Git and NVM support.
# Tested on Linux, Unix and Windows under ANSI colors.
#
# Last update : Sep. 2017 | Julien van der Kluft

# Directory info.
local current_dir='${PWD/#$HOME/~}'

# VCS
YS_VCS_PROMPT_PREFIX="%{$fg[white]%}on%{$reset_color%} %{$fg[cyan]%}"
YS_VCS_PROMPT_SUFFIX="%{$reset_color%}"
YS_VCS_PROMPT_DIRTY=" %{$fg[red]%}✗ "
YS_VCS_PROMPT_CLEAN=" %{$fg[green]%}✔︎ "

# Git info
local git_info='$(git_prompt_info)'
local git_last_commit='$(git log --pretty=format:"%h \"%s\"" -1 2> /dev/null)'
ZSH_THEME_GIT_PROMPT_PREFIX="$YS_VCS_PROMPT_PREFIX"
ZSH_THEME_GIT_PROMPT_SUFFIX="$YS_VCS_PROMPT_SUFFIX"
ZSH_THEME_GIT_PROMPT_DIRTY="$YS_VCS_PROMPT_DIRTY"
ZSH_THEME_GIT_PROMPT_CLEAN="$YS_VCS_PROMPT_CLEAN"

# HG info
local hg_info='$(ys_hg_prompt_info)'
ys_hg_prompt_info() {
  # make sure this is a hg dir
  if [ -d '.hg' ]; then
    echo -n "${YS_VCS_PROMPT_PREFIX1}hg${YS_VCS_PROMPT_PREFIX2}"
    echo -n $(hg branch 2>/dev/null)
    if [ -n "$(hg status 2>/dev/null)" ]; then
      echo -n "$YS_VCS_PROMPT_DIRTY"
    else
      echo -n "$YS_VCS_PROMPT_CLEAN"
    fi
    echo -n "$YS_VCS_PROMPT_SUFFIX"
  fi
}

# NVM info
local nvm_info='$(nvm_prompt_info)'
ZSH_THEME_NVM_PROMPT_PREFIX="%{$fg[green]%}⬡ "
ZSH_THEME_NVM_PROMPT_SUFFIX=""

# Prompt format: \n [DIRECTORY] on git:BRANCH STATE \n [TIME] > $
PROMPT="
%{$terminfo[bold]$fg[yellow]%}[${current_dir}]%{$reset_color%}\
${hg_info} \
${git_info}\
${git_last_commit}
%{$fg[white]%}%* \
%{$fg[white]%}› %{$reset_color%}"

RPROMPT="${nvm_info}%{$reset_color%}"
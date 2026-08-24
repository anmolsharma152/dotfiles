#!/usr/bin/env bash

# Source global definitions
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

# Enable bash programmable completion features
[[ $- == *i* ]] && source /usr/share/bash-completion/bash_completion

#######################################################
# EXPORTS & ENVIRONMENT
#######################################################
export HISTFILESIZE=10000
export HISTSIZE=500
export HISTTIMEFORMAT="%F %T "
export HISTCONTROL=erasedups:ignoredups:ignorespace

shopt -s checkwinsize
shopt -s histappend
PROMPT_COMMAND='history -a'

# Case-insensitive tab completion
if [[ $- == *i* ]]; then
  bind "set completion-ignore-case on"
  # This specifically helps with directory-only completion
  bind "set show-all-if-ambiguous on"
fi

# Enhanced Bash Menu Completion
if [[ $- == *i* ]]; then
  bind "set completion-ignore-case on"
  bind "set show-all-if-ambiguous on"
  # Add these two lines for Zsh/Fish-like cycling through options:
  bind 'TAB:menu-complete'
  bind '"\e[Z": menu-complete-backward' # Shift+Tab to go backward
fi

# This ignores case for pattern matching (e.g., ls *.jpg)
shopt -s nocaseglob

# XDG Base Directory Specification
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"

# Set default editors
export EDITOR=nvim
export VISUAL=nvim

# Colors for ls
export CLICOLOR=1
export LS_COLORS='no=00:fi=00:di=00;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:*.xml=00;31:'

# Manpage colors
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

# Wayland Platform Check
if [[ $XDG_SESSION_TYPE == "wayland" ]]; then
  unset QT_QPA_PLATFORM
else
  export QT_QPA_PLATFORM=xcb
fi

export PATH="$HOME/.cargo/bin:$PATH:$HOME/.local/bin:/var/lib/flatpak/exports/bin:$HOME/.local/share/flatpak/exports/bin"

# npm global binaries
export PATH="$PATH:$HOME/.npm-global/bin"

#######################################################
# ALIASES
#######################################################
alias ebrc='nvim ~/.bashrc'
alias sbrc='source ~/.bashrc'

# File operations
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
alias mkdir='mkdir -p'

# Navigation & Listing
alias ..='cd ..'
alias ...='cd ../..'
alias lsa='ls -aFh --color=always'
alias lsl='ls -alFh --color=always'
alias ll='ls -l'
alias tree='tree -CAhF --dirsfirst'

# Git
alias g='git'
alias gs='git status'
alias ga='git add'
alias gcm='git commit -m'
alias gps='git push'
alias gpl='git pull'
alias gd='git diff'

# Proton VPN Shorthands
alias vpn-on="protonvpn connect"
alias vpn-off="protonvpn disconnect"
alias vpn-stat="protonvpn status"

# Utilities
# Remove or comment out these lines:
# if command -v rg &>/dev/null; then alias grep='rg'; else alias grep="grep --color=auto"; fi
alias grep='grep --color=auto'
alias p="ps aux | grep "
alias h="history | grep "
alias openports='sudo ss -tulpn'
alias docker-clean='docker container prune -f ; docker image prune -f ; docker network prune -f ; docker volume prune -f'

#######################################################
# INITIALIZATION & LAZY LOADING
#######################################################

# Lazy Load Conda
conda() {
  unset -f conda
  __conda_setup="$('/home/anmol/miniconda3/bin/conda' 'shell.bash' 'hook' 2>/dev/null)"
  if [ $? -eq 0 ]; then
    eval "$__conda_setup"
  else
    if [ -f "/home/anmol/miniconda3/etc/profile.d/conda.sh" ]; then
      . "/home/anmol/miniconda3/etc/profile.d/conda.sh"
    else
      export PATH="/home/anmol/miniconda3/bin:$PATH"
    fi
  fi
  unset __conda_setup
  conda "$@"
}

# Zoxide: A smarter CD
eval "$(zoxide init bash)"

# Move Starship to the absolute bottom
# eval "$(starship init bash)"

# Default bash shell config
PS1='\[\e[1;32m\]\u@\h\[\e[0m\]:\[\e[1;34m\]\w\[\e[0m\]\$ '

. "$HOME/.local/share/../bin/env"

export PATH="$HOME/.local/share/go/bin:$PATH"

export GODEBUG=http2client=0

# opencode
export PATH=/home/anmol/.opencode/bin:$PATH

# >>> grok installer >>>
export PATH="$HOME/.grok/bin:$PATH"
[[ -r "$HOME/.grok/completions/bash/grok.bash" ]] && source "$HOME/.grok/completions/bash/grok.bash"
# <<< grok installer <<<

# OpenClaw Completion
[ -f "/home/anmol/.openclaw/completions/openclaw.bash" ] && source "/home/anmol/.openclaw/completions/openclaw.bash"

# Composio CLI
export PATH="$HOME/.local/bin:$PATH"

# Added by Antigravity CLI installer
export PATH="/home/anmol/.local/bin:$PATH"
alias antigravity-cli="agy"

export PGHOST=127.0.0.1
export PGUSER=postgres
export PGPASSWORD=P8x_mK9_vQ2L_zW5nJ7rT3aF6bY4cE1u
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
eval "$(mise activate bash)"

# ==========================================
# ENVIRONMENT & XDG
# ==========================================
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"

typeset -U path PATH

# Set default editors
export EDITOR="nvim"
export VISUAL="nvim"
export SUDO_EDITOR="nvim"
export SYSTEMD_EDITOR="nvim"

export PATH=$PATH:"$HOME/.local/bin:/var/lib/flatpak/exports/bin:$HOME/.local/share/flatpak/exports/bin:$HOME/.npm-global/bin:$HOME/.config/emacs/bin"

# ==========================================
# HISTORY
# ==========================================
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory      # Append to history file immediately
setopt sharehistory       # Share history across multiple zsh sessions
setopt hist_ignore_all_dups # Remove older duplicate entries from history
setopt hist_save_no_dups  # Do not save duplicates
setopt hist_ignore_space  # Ignore commands that start with a space

# ==========================================
# COMPLETION (Native Zsh)
# ==========================================
autoload -Uz compinit
compinit

# Case-insensitive tab completion and menu selection
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' menu select

# Optional: Lightweight syntax highlighting and autosuggestions (Arch Linux native packages)
# Install via: sudo pacman -S zsh-syntax-highlighting zsh-autosuggestions
if [ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
    source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
fi
if [ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
    source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# ==========================================
# ALIASES
# ==========================================
alias ezrc='nvim ~/.zshrc'
alias szrc='source ~/.zshrc'

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

# ==========================================
# INITIALIZATION & LAZY LOADING
# ==========================================

# Lazy Load Conda
conda() {
  unset -f conda
  __conda_setup="$('/home/anmol/miniconda3/bin/conda' 'shell.zsh' 'hook' 2>/dev/null)"
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

eval "$(zoxide init zsh)"
eval "$(starship init zsh)"

. "$HOME/.local/share/../bin/env"

export GODEBUG=http2client=0

# opencode
export PATH=/home/anmol/.opencode/bin:$PATH
export PATH="$HOME/.composio:$PATH"

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# Place at the very end of ~/.zshrc
export PATH="$HOME/.local/share/go/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"

# Added by Antigravity CLI installer
export PATH="/home/anmol/.local/bin:$PATH"
alias antigravity-cli="agy"

export PGHOST=127.0.0.1
export PGUSER=postgres
export PGPASSWORD=P8x_mK9_vQ2L_zW5nJ7rT3aF6bY4cE1u
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
eval "$(mise activate zsh)"

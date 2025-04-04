# ========================================
# 🚀 Powerlevel10k Instant Prompt (Must be First)
# ========================================
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ========================================
# ⚡ Znap Plugin Manager Setup
# ========================================
[[ -r ~/Repos/znap/znap.zsh ]] ||
    git clone --depth 1 -- \
        https://github.com/marlonrichert/zsh-snap.git ~/Repos/znap
source ~/Repos/znap/znap.zsh  # Start Znap


# ========================================
# 🔧 Deferred Initializations
# ========================================
function _init_plugins() {
  # Load plugins asynchronously
  znap source romkatv/powerlevel10k
  znap source jeffreytse/zsh-vi-mode
  znap source zsh-users/zsh-syntax-highlighting
  znap source zsh-users/zsh-completions
  znap source zsh-users/zsh-autosuggestions
  znap source Aloxaf/fzf-tab

  # Oh My Zsh snippets
  local omz_plugins=(
    git
    sudo
    kubectl
    kubectx
    command-not-found
    tmux
  )
  for plugin in $omz_plugins; do
    znap source ohmyzsh/ohmyzsh "plugins/$plugin"
  done
}

# ========================================
# 🎨 Powerlevel10k Configuration
# ========================================
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# ========================================
# ⌨️ Keybindings
# ========================================
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region

# ========================================
# 📜 History Configuration
# ========================================
HISTSIZE=10000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
setopt HIST_FCNTL_LOCK
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS
setopt SHARE_HISTORY

# ========================================
# 🔍 Completion & FZF Configuration
# ========================================
autoload -Uz compinit && compinit -C
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no

# ========================================
# 🏷️ Aliases
# ========================================
alias c='clear'
alias open="xdg-open"
alias wezterm='flatpak run org.wezfurlong.wezterm'

# eza aliases with existence checks
if command -v eza >/dev/null; then
  alias ls='eza --icons'
  alias ll='eza -l --icons'
  alias la='eza -la --icons'
  alias lt='eza -T --icons'
  alias lr='eza -l --reverse --icons'
  alias lS='eza -l --sort=size --icons'
  alias le='eza -l --sort=ext --icons'
  alias l1='eza -1'
  alias ld='eza -ld --icons'
  alias lf='eza -l --icons | grep "^-" '
  alias ldot='eza -ld .* --icons'
  alias lg='eza -l --git --icons'
  alias lgf='eza -l --git --icons | grep "^-" '
  alias lmod='eza -l --sort=modified --icons'
fi

# Instant prompt preamble for Powerlevel10k (if you use it)
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Function to generate Flatpak aliases
generate_flatpak_aliases() {
  # Check if flatpak is installed silently
  if ! command -v flatpak &> /dev/null; then
    return
  fi

  # Get the list of Flatpak apps and process it silently
  flatpak list --app --columns=name,application 2>/dev/null | while read -r name app_id; do
    # Skip the header line
    if [[ "$name" == "Name" ]]; then
      continue
    fi

    # Convert name to lowercase and remove spaces for a clean command
    cmd_name=$(echo "$name" | tr '[:upper:]' '[:lower:]' | tr -d '[:space:]')

    # Create the alias if it doesn't already exist as a command
    if ! command -v "$cmd_name" &> /dev/null; then
      alias "$cmd_name"="flatpak run $app_id"
    fi
  done
}

# Run the function after instant prompt
generate_flatpak_aliases

# Your Powerlevel10k configuration (if it exists)
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# ========================================
# 📌 Shell Integrations (Silenced)
# ========================================
if [[ -n "$PS1" ]]; then
  eval "$(fzf --zsh 2>/dev/null)"
  eval "$(zoxide init --cmd cd zsh 2>/dev/null)"
fi

# ========================================
# 🐍 Conda Initialization (Silenced)
# ========================================
__conda_setup="$('/home/youssef/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
elif [ -f "/home/youssef/anaconda3/etc/profile.d/conda.sh" ]; then
    . "/home/youssef/anaconda3/etc/profile.d/conda.sh" >/dev/null 2>&1
else
    export PATH="/home/youssef/anaconda3/bin:$PATH"
fi
unset __conda_setup

# ========================================
# 🎯 NVM Setup (Silenced)
# ========================================
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  >/dev/null 2>&1
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" >/dev/null 2>&1

# ========================================
# ⚡ Defer Plugin Loading
# ========================================
_init_plugins

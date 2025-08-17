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
alias cursor='/opt/cursor/cursor.AppImage'
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
# 🐍 Conda Manual Initialization
# ========================================
function init_conda() {
  if [[ -z "$CONDA_INITIALIZED" ]]; then
    echo "🐍 Initializing Conda environment..."
    __conda_setup="$('/home/youssef/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    else
        if [ -f "/home/youssef/anaconda3/etc/profile.d/conda.sh" ]; then
            . "/home/youssef/anaconda3/etc/profile.d/conda.sh"
        else
            export PATH="/home/youssef/anaconda3/bin:$PATH"
        fi
    fi
    unset __conda_setup
    export CONDA_INITIALIZED=1
    echo "✅ Conda initialized successfully! You can now use conda commands."
  else
    echo "✅ Conda is already initialized in this session."
  fi
}

# Add conda to PATH without activating
export PATH="/home/youssef/anaconda3/bin:$PATH"

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"

# ========================================
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  >/dev/null 2>&1
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" >/dev/null 2>&1

# ========================================
# ⚡ Defer Plugin Loading
# ========================================
_init_plugins

# Your conda environment is NOT automatically initialized
# Use 'init_conda' command when you need to work with conda


# pnpm
export PNPM_HOME="/home/youssef/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

export QT_QPA_PLATFORMTHEME=qt5ct

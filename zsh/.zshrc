# # Set the directory we want to store zinit and plugins
# ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# # Download Zinit, if it's not there yet
# if [ ! -d "$ZINIT_HOME" ]; then
#    mkdir -p "$(dirname $ZINIT_HOME)"
#    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
# fi

# # Source/Load zinit
# source "${ZINIT_HOME}/zinit.zsh"

# # Add in Powerlevel10k
# zinit ice depth=1; zinit light romkatv/powerlevel10k
# zinit ice depth=1; zinit light jeffreytse/zsh-vi-mode

# # Add in zsh plugins
# zinit light zsh-users/zsh-syntax-highlighting
# zinit light zsh-users/zsh-completions
# zinit light zsh-users/zsh-autosuggestions
# zinit light Aloxaf/fzf-tab

# # Add in snippets
# zinit snippet OMZL::git.zsh
# zinit snippet OMZP::git
# zinit snippet OMZP::sudo
# zinit snippet OMZP::archlinux
# zinit snippet OMZP::aws
# zinit snippet OMZP::kubectl
# zinit snippet OMZP::kubectx
# zinit snippet OMZP::command-not-found

# # Load completions
# autoload -Uz compinit && compinit

# zinit cdreplay -q

# # To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# # Keybindings
# bindkey -e
# bindkey '^p' history-search-backward
# bindkey '^n' history-search-forward
# bindkey '^[w' kill-region

# # History
# HISTSIZE=5000
# HISTFILE=~/.zsh_history
# SAVEHIST=$HISTSIZE
# HISTDUP=erase
# setopt appendhistory
# setopt sharehistory
# setopt hist_ignore_space
# setopt hist_ignore_all_dups
# setopt hist_save_no_dups
# setopt hist_ignore_dups
# setopt hist_find_no_dups

# # Completion styling
# zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
# zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
# zstyle ':completion:*' menu no
# zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
# zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# # Aliases
# alias vim='nvim'
# alias c='clear'
# alias open="xdg-open"
# alias wezterm='flatpak run org.wezfurlong.wezterm'


# # eza Aliases
# alias ls='eza --icons'             # Default `ls` with icons
# alias ll='eza -l --icons'          # Long format
# alias la='eza -la --icons'         # Long format with hidden files
# alias lt='eza -T --icons'          # Tree view
# alias lr='eza -l --reverse --icons' # Reverse sort by default
# alias lS='eza -l --sort=size --icons' # Sort by size
# alias le='eza -l --sort=ext --icons'  # Sort by file extension
# alias l1='eza -1'                  # List one entry per line
# alias ld='eza -ld --icons'         # Show only directories
# alias lf='eza -l --icons | grep "^-" ' # Show only files
# alias ldot='eza -ld .* --icons'    # Show only hidden directories
# alias lg='eza -l --git --icons'    # Show git status along with listing
# alias lgf='eza -l --git --icons | grep "^-" ' # Show only git-tracked files
# alias lmod='eza -l --sort=modified --icons' # Sort by last modified time


# # Shell integrations
# eval "$(fzf --zsh)"
# eval "$(zoxide init --cmd cd zsh)"

# # >>> conda initialize >>>
# # !! Contents within this block are managed by 'conda init' !!
# __conda_setup="$('/home/youssef/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
# if [ $? -eq 0 ]; then
#     eval "$__conda_setup"
# else
#     if [ -f "/home/youssef/anaconda3/etc/profile.d/conda.sh" ]; then
#         . "/home/youssef/anaconda3/etc/profile.d/conda.sh"
#     else
#         export PATH="/home/youssef/anaconda3/bin:$PATH"
#     fi
# fi
# unset __conda_setup
# # <<< conda initialize <<<

# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


# ==============================
# 🚀 Oh My Posh + Znap Config
# ==============================

# 🔹 Load Oh My Posh (Change theme as needed)
eval "$(oh-my-posh init zsh --config ~/.poshthemes/robbyrussell.omp.json)"

# 🔹 Load Znap
source ~/.zsh-snap/znap.zsh

# ==============================
# 📌 Plugins (Fast & Lazy Loaded)
# ==============================

# Install Plugins (Runs once)
if [[ ! -f ~/.zsh_plugins.znap ]]; then
  znap install \
    zsh-users/zsh-syntax-highlighting \
    zsh-users/zsh-autosuggestions \
    zsh-users/zsh-completions \
    Aloxaf/fzf-tab
fi

# Load Plugins
znap source zsh-users/zsh-syntax-highlighting
znap source zsh-users/zsh-autosuggestions
znap source zsh-users/zsh-completions
znap source Aloxaf/fzf-tab

# Fast Startup
znap compile

# ==============================
# 🎯 Keybindings & History
# ==============================

bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region

# History Settings
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory sharehistory
setopt hist_ignore_space hist_ignore_all_dups hist_save_no_dups hist_ignore_dups hist_find_no_dups

# ==============================
# 🔧 Aliases
# ==============================

alias vim='nvim'
alias c='clear'
alias open="xdg-open"
alias wezterm='flatpak run org.wezfurlong.wezterm'

# eza Aliases
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

# ==============================
# 🔄 Shell Integrations
# ==============================

eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"

# ==============================
# 🐍 Conda (if needed)
# ==============================

__conda_s

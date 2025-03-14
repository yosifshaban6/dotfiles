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

# ==============================
# 🎯 Node Version Manager (NVM)
# ==============================

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

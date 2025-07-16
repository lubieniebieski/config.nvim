# ===== ENVIRONMENT =====
export LC_ALL=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8

# ===== PATH MANAGEMENT =====
# Personal bin directory
export PATH="$HOME/.bin:$PATH"

# Homebrew (Apple Silicon)
export PATH="/opt/homebrew/bin:$PATH"

# ===== SHELL OPTIONS =====
# History settings
setopt HIST_IGNORE_ALL_DUPS     # Don't record duplicates in history
setopt HIST_FIND_NO_DUPS        # Don't display duplicates when searching
setopt HIST_SAVE_NO_DUPS        # Don't save duplicates to history file
setopt SHARE_HISTORY            # Share history between all sessions
setopt APPEND_HISTORY           # Append to history file rather than replace
setopt HIST_VERIFY              # Show command with history expansion to user before running it

# Completion improvements
setopt COMPLETE_ALIASES         # Complete aliases
setopt GLOB_COMPLETE            # Generate matches from globbing
setopt LIST_PACKED              # Make completion lists more compact

# Disable corrections
unsetopt CORRECT_ALL            # Don't try to correct all arguments

# ===== EXTERNAL TOOLS =====
# rbenv (Ruby version manager)
command -v rbenv >/dev/null 2>&1 && eval "$(rbenv init - --no-rehash)"

# slimzsh
[ -f "$HOME/.slimzsh/slim.zsh" ] && source "$HOME/.slimzsh/slim.zsh"

# fzf - fuzzy matching
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# zoxide - smarter cd command
command -v zoxide >/dev/null 2>&1 && eval "$(zoxide init zsh)"

# ===== ALIASES =====

# List files
alias ll='ls -oghF'
alias la='ls -A'
alias l='ls -CF'

# Git shortcuts
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git pull'

# Utility
alias grep='grep --color=auto'

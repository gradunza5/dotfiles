# set zinit directory 
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
    mkdir -p "$(dirname $ZINIT_HOME)"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load Zinit
source "${ZINIT_HOME}/zinit.zsh"

zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# load snippets from Oh-My-Zsh
zinit ice lucid wait
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::command-not-found

# for completions
autoload -U compinit && compinit
zmodload zsh/complist

# replays cached completions
zinit cdreplay -q

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups
setopt CORRECT

# Keybinds
bindkey '^[[1;5D' backward-word  # Ctrl+Left
bindkey '^[[1;5C' forward-word   # Ctrl+Right
bindkey -M menuselect '^[[Z' reverse-menu-complete  # Shift+Tab
setopt interactive_comments

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# set editor
export EDITOR="nvim"

alias vr='NVIM_APPNAME=nvim-renew nvim'
alias vj='NVIM_APPNAME=nvim-jon ~/mine/code/tools/nvim-macos-x86_64/bin/nvim'

# aliases 
alias x="exit"
alias sd="sudo shutdown -h now"
alias gs="git status"
alias mux="tmuxinator"

alias ff="fastfetch"

alias ..="cd .."
alias ...="cd ../.."

# if eza exists on the system, its config will overwrite this later in `my_init`
alias l="ls -lh --color"
alias v="ls -lah --color"

# PATH
alias path='echo $PATH | sed "s#:#/\n#g"'

eval "$(fzf --zsh)"

[[ -e "$HOME/.fzf-extras/fzf-extras.sh" ]] \
  && source "$HOME/.fzf-extras/fzf-extras.sh"

[[ -e "$HOME/.fzf-git.sh" ]] \
  && source "$HOME/.fzf-git.sh"

# zoxide
eval "$(zoxide init --cmd cd zsh)"

# eza 
if ! type "$eza" > /dev/null; then
    export FPATH="~/mine/code/tools/eza/completions/zsh:$FPATH"

    alias l="eza -lh --icons --git --color-scale -o"
    alias v="eza -lha --icons --git --color-scale -o"
fi

# Yazi shell wrapper to cd when exiting
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# local machine-specific overrides
[[ -e "$HOME/.zsh-local" ]] && source "$HOME/.zsh-local"

# enable starship
eval "$(starship init zsh)"

# Created by `pipx` on 2025-06-26 20:56:01
export PATH="$PATH:/Users/benreeves/.local/bin"

## [Completion]
## Completion scripts setup. Remove the following line to uninstall
[[ -f /Users/benreeves/.dart-cli-completion/zsh-config.zsh ]] && . /Users/benreeves/.dart-cli-completion/zsh-config.zsh || true
## [/Completion]


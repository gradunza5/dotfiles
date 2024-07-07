# set zinit directory 
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
    mkdir -p "$(dirname $ZINIT_HOME)"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load Zinit
source "${ZINIT_HOME}/zinit.zsh"

# config for zsh vi mode - keep before plugin load
function zvm_config() {
    #ZVM_LINE_INIT_MODE=$ZVM_MODE_NORMAL
    ZVM_VI_INSERT_ESCAPE_BINDKEY=jk
    ZVM_VI_EDITOR=nvim
}

# plugins that modify keybinds need to be set up after vi mode loads; 
# keep before plugin load
function my_init() {
    # fzf integration
    eval "$(fzf --zsh)"

    [[ -e "$HOME/.fzf-extras/fzf-extras.zsh" ]] \
      && source "$HOME/.fzf-extras/fzf-extras.zsh"

    [[ -e "$HOME/.fzf.zsh" ]] \
      && source "$HOME/.fzf.zsh"

    [ -f ~/.fzf-git.sh ] && source ~/.fzf-git.sh

    # zoxide
    eval "$(zoxide init --cmd cd zsh)"

    # eza 
    if ! type "$eza" > /dev/null; then
        export FPATH="~/mine/code/tools/eza/completions/zsh:$FPATH"

        alias l="eza -lh"
        alias v="eza -lah"
    fi
}

function zvm_after_lazy_keybindings() {

    zvm_bindkey viins '^G ^B' _fzf_git_branches

}

zvm_after_init_commands+=(my_init)

zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab
zinit ice depth=1; zinit light jeffreytse/zsh-vi-mode

# load snippets from Oh-My-Zsh
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::command-not-found

# for completions
autoload -U compinit && compinit

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

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zocide_z:*' fzf preview 'ls --color $realpath'

# set editor
export EDITOR="nvim"

# aliases 
alias ls='ls --color'
alias x="exit"
alias sd="sudo shutdown -h now"
alias gs="git status"
alias mux="tmuxinator"
alias nvim-exp='NVIM_APPNAME="nvim-exp" nvim'
alias nvim-ks='NVIM_APPNAME="nvim-kickstart" nvim'

# if eza exists on the system, its config will overwrite this later
alias l="ls -lh --color"
alias v="ls -lah --color"

# local machine-specific overrides
[[ -e "$HOME/.zsh-local" ]] && source "$HOME/.zsh-local"

# enable starship
eval "$(starship init zsh)"

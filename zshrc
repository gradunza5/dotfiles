# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
# SH_THEME="robbyrussell"
#ZSH_THEME="mh"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# vim encryption!
alias vime="vim -u ~/.vimencrc -x"

# ctrl-backspace?
bindkey '^K' backward-kill-word

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# ZSH Won't prompt for update, it'll just do it and probably fail.
DISABLE_UPDATE_PROMPT=true

# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
if [[ `uname` == "Darwin" ]]; then
	plugins=(git svn macos taskwarrior)
else
	plugins=(git svn taskwarrior)
fi

source $ZSH/oh-my-zsh.sh

# for syntax
source ~/dotfiles/syntax.zsh

# mh theme configured to show hostname
source ~/dotfiles/zsh-prompt.zsh

# for qt
export PATH=$PATH:/usr/local/qt4/bin

# for ruby? Add RVM to PATH for scripting
export PATH=$PATH:$HOME/.rvm/bin 

# for go
export GOPATH=$HOME/code/go
export PATH=$PATH:$GOPATH/bin

# for dotnet tools
export PATH="$PATH:/Users/benreeves/.dotnet/tools"

# some mac stuff
if [[ `uname` == "Darwin" ]]; then
	export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/opt/X11/lib/pkgconfig
	export PATH=/usr/pkg/bin:/usr/pkg/sbin:$PATH
	
	# for newer subversion
	export PATH=/opt/subversion/bin:$PATH

    # for gnu ls and things
    PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
    MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"

	export MANPATH=/usr/pkg/man:$MANPATH

	alias updatedb="sudo /usr/libexec/locate.updatedb"
	alias tmux="tmux -2"
	alias ctags="/usr/local/bin/ctags"
	export EDITOR="vim"

     #Add GHC 7.8.3 to the PATH, via http://ghcformacosx.github.io/
     export GHC_DOT_APP="/Applications/ghc-7.8.3.app"
     if [ -d "$GHC_DOT_APP" ]; then
         export PATH="${HOME}/.cabal/bin:${GHC_DOT_APP}/Contents/bin:${PATH}"
     fi
fi

# for dircolors
#eval $(dircolors ~/.dircolors)

#android tools
export ANDROID_HOME=/Users/benreeves/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/android
export PATH=$PATH:$ANDROID_HOME/platforms
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin/

# react wants this, I guess
export ANDROID_SDK_ROOT=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_SDK_ROOT/emulator
export PATH=$PATH:$ANDROID_SDK_ROOT/platform-tools

#add maven to path
export PATH=/usr/local/Cellar/maven/3.8.6/libexec:$PATH

#java home
export JAVA_13_HOME=$(/usr/libexec/java_home -v13)
export JAVA_HOME=$JAVA_13_HOME
export JDK_HOME=$JAVA_13_HOME

export PATH="$HOME/.gem/ruby/2.6.0/bin:$PATH"
export PATH="$PATH:/Users/benreeves/Library/flutter/bin"
export PATH="$PATH:/Users/benreeves/.pub-cache/bin"

alias x="exit"

alias l="ls -lh --color=auto"
alias v="ls -lah --color=auto"

alias gs="git status"

alias mux="tmuxinator"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f ~/mine/code/fzf-git.sh/fzf-git.sh ] && source ~/mine/code/fzf-git.sh/fzf-git.sh

## [Completion]
## Completion scripts setup. Remove the following line to uninstall
[[ -f /Users/benreeves/.dart-cli-completion/zsh-config.zsh ]] && . /Users/benreeves/.dart-cli-completion/zsh-config.zsh || true
## [/Completion]


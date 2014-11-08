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
alias wineSteam="~/code/utils/scripts/wineSteam.sh"
#alias steam="~/code/utils/scripts/steam.sh"
alias wow="~/code/utils/scripts/wow.sh"

alias cam="guvcview"

alias gw2="~/code/utils/scripts/gw2.sh"

alias x="exit"
alias sd="sudo shutdown -h now"

alias config="vim ~/.xmonad/xmonad.hs"

alias bootwin="/home/ben/code/utils/scripts/bootwin.sh"

alias l="ls -lh --color=auto"
alias v="ls -lah --color=auto"

# vim encryption!
alias vime="vim -u ~/.vimencrc -x"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

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
	plugins=(git svn osx taskwarrior)
else
	plugins=(git svn taskwarrior)
fi

source $ZSH/oh-my-zsh.sh

# for syntax
source ~/dotfiles/syntax.zsh

# mh theme configured to show hostname
source ~/dotfiles/zsh-prompt.zsh

# Customize to your needs...
export PATH=$PATH:/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/bin/vendor_perl:/usr/bin/core_perl
export PATH=$PATH:~/.cabal/bin:~/.xmonad/bin

# for qt
export PATH=$PATH:/usr/local/qt4/bin

# for ruby?
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

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
fi

# for dircolors
eval $(dircolors ~/.dircolors)

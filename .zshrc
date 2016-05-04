# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="bullet-train"

# bullet-traing theme hide ruby
BULLETTRAIN_RUBY_SHOW=true

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias nyancat="/Users/benweeks/source/nyancat/src/nyancat"
alias webicon="/Users/benweeks/source/webicon/webicon.sh"
zstyle ':completion:*:*:git:*' script ~/.git-completion.sh

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
plugins=(git)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
# Workon
export PATH=$PATH:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/git/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/git/bin
export WORKON_HOME=$HOME/code/envs
export PROJECT_HOME=$HOME/Projects
source /usr/local/bin/virtualenvwrapper.sh
export PATH=/usr/local/sbin:$PATH

# Autoenv
source ~/.autoenv/activate.sh

# Custom script for courses
tarcourse() { /usr/local/bin/tarcourse.sh "$1"; }
# Custom script for favicon, from
# http://eclecticquill.com/2012/12/11/favicon-with-imagemagick/
favicon-maker() { /usr/local/bin/favicon.sh "$1"; }

# Per suggestion of zsh, aliases for help.
unalias run-help
autoload run-help
HELPDIR=/usr/local/share/zsh/help

# use ~/.secrets file to hold secret API keys etc.
# # Put these lines in your .zshrc or .bashrc

 if [[ -a ~/.secrets ]]
   then
     source ~/.secrets
 fi

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# Add docker-machine

# if [[ $(docker-machine status default) == 'Running' ]]
#     eval $(docker-machine env default)

### Add rbenv
eval "$(rbenv init -)"

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="bullet-train"

### git prompt inclusion
# source ~/.dotfiles/.git-prompt.sh

# bullet-traing theme hide ruby
BULLETTRAIN_RUBY_SHOW=FALSE

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias webicon="/Users/benweeks/source/webicon/webicon.sh"
alias code="cd ~/code"
alias downloads="cd ~/downloads"
alias documents="cd ~/documents"
# zstyle ':completion:*:*:git:*' script ~/.git-completion.sh

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
plugins=(gitfast encode64 docker grails npm osx python sudo systemd tmux urltools vagrant)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
# Workon
export PATH=$PATH:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/git/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/git/bin
export WORKON_HOME=$HOME/code/envs
export PROJECT_HOME=$HOME/Projects
VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python3
source /usr/local/bin/virtualenvwrapper.sh
export PATH=/usr/local/sbin:$PATH

# Autoenv
# source ~/.autoenv/activate.sh not needed on OS X thanks to homebrew

# Custom script for courses, not useful outside of ODL
# tarcourse() { /usr/local/bin/tarcourse.sh "$1"; }
# Custom script for favicon, from
# http://eclecticquill.com/2012/12/11/favicon-with-imagemagick/
favicon-maker() { /usr/local/bin/favicon.sh "$1"; }

subfolder-git() { /usr/local/bin/subfolder-git.sh "$1"; }

# Per suggestion of zsh, aliases for help.
#unalias run-help
autoload run-help
HELPDIR=/usr/local/share/zsh/help

# use ~/.secrets folder to hold secret API keys etc.

if [[ -a ~/.secrets ]]
    then
    source ~/.secrets
fi

# Add docker-machine

# if [[ $(docker-machine status default) == 'Running' ]]
#     eval $(docker-machine env default)

### Add rbenv
#eval "$(rbenv init -)"

### Environment Variable to CTCT's Build Process.
export JAVA_HOME=`/usr/libexec/java_home`

### Adding a path for zShell completions/integrations
fpath=(~/.zsh $fpath)

### GoPath
#export GOPATH='/usr/local/go/pkg'

### Set vim keybindings
#bindkey -v

### Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

### Add completion for AWS cli.
source /usr/local/etc/aws_zsh_completer.sh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


### api_gateway_swagger alias from Randy
swag() {
java -jar /Users/bweeks/code/api_gateway_swagger_processor/target/swagger-processor-1.71-SNAPSHOT.jar US-EAST default "$1"
}

### homebrew is using python3.7 for default `python` command but still requires pip3 to install to that runtime for some dumb reason.
pip() {
pip3 "$@"
}

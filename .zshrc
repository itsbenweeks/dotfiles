if [[ $TERM == 'xterm-kitty' ]]
  then
  autoload -Uz compinit
  compinit
  kitty + complete setup zsh | source /dev/stdin
fi
# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="powerlevel10k/powerlevel10k"

### git prompt inclusion
# source ~/.dotfiles/.git-prompt.sh

# bullet-traing theme hide ruby
BULLETTRAIN_RUBY_SHOW=FALSE
BULLETTRAIN_NODE_SHOW=FALSE

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias webicon="$HOME/source/webicon/webicon.sh"
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
plugins=(gitfast docker npm osx python sudo systemd tmux urltools)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
# Workon
export PATH=$PATH:/usr/local/bin:/usr/local/sbin/:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/git/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/git/bin
export WORKON_HOME=$HOME/code/envs
export PROJECT_HOME=$HOME/Projects

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

### Adding a path for zShell completions/integrations
fpath=(~/.zsh/completion $fpath)

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

source ~/source/powerlevel10k/powerlevel10k.zsh-theme

## AWS Quick Commands
function get_ec2_instance_id_by_name() {
    EC2_NAME=$1
    if [ -n "$2" ]; then
        AWS_REGION=$2
    else
        AWS_REGION=us-east-1
    fi
    aws ec2 describe-instances\
        --region $AWS_REGION\
        --query "Reservations[*].Instances[*].[InstanceId]"\
        --filters "Name=tag:Name,Values=$EC2_NAME"\
        --output text|head -n 1
}

function get_ec2_ip_by_name() {
    EC2_NAME=$1
    if [ -n "$2" ]; then
        AWS_REGION=$2
    else
        AWS_REGION=us-east-1
    fi
    aws ec2 describe-instances\
        --region $AWS_REGION\
        --query "Reservations[*].Instances[0].[PrivateIpAddress]"\
        --filters "Name=tag:Name,Values=$EC2_NAME"\
        --output text|head -n 1
}

## Connect to ec2 instance with name, pem, and region.
# If there are more than 3 program parameters, then send 
# the addition 3+ as a command over ssh.
function connect_to_ec2() {
    PEM_FILE=$1
    EC2_NAME=$2
    AWS_REGION=$3
    if [[ "$#" -eq 3 ]]; then
        EC2_IP=$(get_ec2_ip_by_name $2 $3)
    else
        EC2_IP=$(get_ec2_ip_by_name $2)
    fi
    if [[ "$#" -gt 3 ]]; then
        ssh -i "$1" ec2-user@$EC2_IP "${@:4}"
    else
        ssh -i "$1" ec2-user@$EC2_IP
    fi
}

function connect_to_ec2_tty() {
    PEM_FILE=$1
    EC2_NAME=$2
    AWS_REGION=$3
    EC2_IP=$(get_ec2_ip_by_name $2 $3)
    if [[ "$#" -gt 3 ]]; then
        ssh -t -i "$1" ec2-user@$EC2_IP "${@:4}"
    else
        ssh -t -i "$1" ec2-user@$EC2_IP
    fi
}

function ec2_docker_manage() {
    PEM_FILE=$1
    EC2_NAME=$2
    AWS_REGION=$3
    DOCKER_NAME=$4
    DOCKER_MANAGE='docker exec $(docker ps -f name=$DOCKER_NAME --latest --format {{.Names}}) python manage.py'
    if [[ "$#" -gt 4 ]]; then
        connect_to_ec2 $PEM_FILE $EC2_NAME $AWS_REGION "$DOCKER_MANAGE ${@:5}"
    else
        connect_to_ec2 $PEM_FILE $EC2_NAME $AWS_REGION "$DOCKER_MANAGE"
    fi
}

function ec2_docker_dj_shell() {
    PEM_FILE=$1
    EC2_NAME=$2
    AWS_REGION=$3
    DOCKER_NAME=$4
    DOCKER_SHELL='docker exec -it $(docker ps -f name=$DOCKER_NAME --latest --format {{.Names}}) python manage.py shell_plus'
    if [[ "$#" -gt 4 ]]; then
        connect_to_ec2_tty $PEM_FILE $EC2_NAME $AWS_REGION "$DOCKER_SHELL ${@:5}"
    else
        connect_to_ec2_tty $PEM_FILE $EC2_NAME $AWS_REGION "$DOCKER_SHELL"
    fi
}

function ec2_docker_bash() {
    PEM_FILE=$1
    EC2_NAME=$2
    AWS_REGION=$3
    DOCKER_NAME=$4
    DOCKER_BASH='docker exec -it $(docker ps -f name=$DOCKER_NAME --latest --format {{.Names}}) bash'
    if [[ "$#" -gt 4 ]]; then
        connect_to_ec2_tty $PEM_FILE $EC2_NAME $AWS_REGION "$DOCKER_BASH ${@:5}"
    else
        connect_to_ec2_tty $PEM_FILE $EC2_NAME $AWS_REGION "$DOCKER_BASH"
    fi
}

## Local Docker Container Commands
export DJANGO_WEB_DOCKER="django_web_1"

### Run bash in the web docker container,
function local_docker_bash() {
    docker exec -it $DJANGO_WEB_DOCKER bash
}

### Run the whole pytest suite in your web docker container.
function django_test() {
    docker exec -t $DJANGO_WEB_DOCKER bash -c "python manage.py test --keepdb --noinput"
}

### Run an IPython notebook instance from the web docker container,
# configured to run shell_plus's imports for ease of use.
function django_notebook() {
    docker exec -it $DJANGO_WEB_DOCKER bash -c "python manage.py shell_plus --notebook"
}

function django_shell() {
    docker exec -it $DJANGO_WEB_DOCKER bash -c "python manage.py shell_plus"
}

### Run a manage.py command in the web docker container,
function django_manage() {
    docker exec -t $DJANGO_WEB_DOCKER bash -c "python manage.py $*"
}

### Load .env to shell
function load_env() {
    if [ -f .env ]; then
        export $(cat < .env | sed 's/#.*//g' | xargs)
    else
        echo ".env file not found"
    fi
}

### Cut a release branch in git from the `master` branch. 
function cut_release() {
    # Get branches from all remotes so we can check for them.
    git fetch --all
    BRANCH_PREFIX=release/$(date +"%Y.%m.%d")
    # Check the remote for branches that have the release/DATE, get the highest suffix, cut out the suffix, then add 1. Defaults to 001.
    BRANCH_SUFFIX=$(printf "%03d" $(($(git ls-remote --heads origin "$BRANCH_PREFIX.\*" | tail -1 | cut -d '.' -f 4) + 1)))
    BRANCH_NAME="$BRANCH_PREFIX.$BRANCH_SUFFIX"
    # Using a refspec here to take the remote origin's `master` branch and put it into our local `release/DATE.SUFFIX` branch.
    git fetch origin "+refs/heads/master:refs/heads/$BRANCH_NAME"
    echo "Branch $BRANCH_NAME created."
    # Again, using a refspec here to take our local `release/DATE.SUFFIX` branch and push it to the remote origin's `release/DATE.SUFFIX` branch.
    git push origin "+refs/heads/$BRANCH_NAME:refs/heads/$BRANCH_NAME"
    echo "Branch $BRANCH_NAME pushed to remote."
    exit 1
}
export PATH="/opt/homebrew/bin:$PATH"

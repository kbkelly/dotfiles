export APPLICATION_ENV="development"

#export PYTHON_BIN="/opt/local/Library/Frameworks/Python.framework/Versions/2.7/bin"
# Needed for EC2 API Tools
export JAVA_HOME=$(/usr/libexec/java_home)
export EC2_PRIVATE_KEY="$(/bin/ls $HOME/.ec2/pk-*.pem)"
export EC2_CERT="$(/bin/ls $HOME/.ec2/cert-*.pem)"
export EC2_HOME="/usr/local/Cellar/ec2-api-tools/1.4.2.2/jars"

export HADOOP_HOME="/usr/local/Cellar/hadoop/0.21.0"
export HADOOP_COMMON_HOME="$HADOOP_HOME"
export HASKELL_PATH="~/.cabal/bin"
export NODE_PATH="/usr/local/lib/node"
export RUBY_GEM_BIN="/usr/local/Cellar/ruby/1.9.3-p0/bin"
export PATH="/usr/local/bin:$HADOOP_HOME/bin:$RUBY_GEM_BIN:$HASKELL_PATH:/usr/local/sbin:/usr/local/mysql/bin:/usr/X11/bin:/Developer/usr/bin:$PATH"
export EDITOR="vim"
export GIT_PAGER=cat

# XDebug
export XDEBUG_CONFIG="idekey=1"

function mysql_start {
    launchctl load -w ~/Library/LaunchAgents/com.mysql.mysqld.plist
}

function mysql_stop {
    launchctl unload -w ~/Library/LaunchAgents/com.mysql.mysqld.plist
}

function mysql_restart {
    mysql_stop && mysql_start
}

function apache_restart {
    sudo apachectl restart
}

function apache_stop {
    sudo apachectl shutdown
}

function redis_start {
    redis-server /usr/local/etc/redis.conf
}

alias sql="mysql -u root -p"
alias ql="qlmanage -p 2>/dev/null"

trim() { echo $1; }

function external_ip {
    ip=`curl -sf http://checkip.dyndns.org/|cut -d ':' -f 2|cut -d '<' -f1|sed -e 's/ //g'`
    echo $(trim $ip)
}

# AWS

function ec2-add-ip {
    ec2-authorize default -p 22 -s $(external_ip)/32
}

# Usage: 
#
# To load e.g. the personal-micro instance (info in personal-micro.txt):
# ec2-login personal-micro 
function ec2-login {
    {
    read user
    read host
    read key
    } < ~/.ec2/$1.txt

    ssh -i $HOME/.ec2/$key $user@$host
}

export AWS_CLOUDFORMATION_HOME="~/aws/AWSCloudFormation-1.0.6/"
export AWS_CREDENTIAL_FILE="~/aws/AWSCloudFormation-1.0.6/credential-file-path.template"
export PATH="$AWS_CLOUDFORMATION_HOME/bin:$PATH"

# Git configs

#source '/usr/local/git/contrib/completion/git-completion.bash'
if [ -f `brew --prefix`/etc/bash_completion ]; then
    . `brew --prefix`/etc/bash_completion
fi


# Git
alias gd="git diff | mate"
alias gl="git log remotes/trunk.."
alias gs="git status"
alias gsl="git stash list"
alias gsr="git svn rebase"

function gsd {
    if [[ $1 ]]; then
        stash="stash@{$1}"
    else
        stash="stash@{0}"
    fi
    git stash drop $stash
}

function gsh {
    if [[ $1 ]]; then
        stash="stash@{$1}"
    else
        stash="stash@{0}"
    fi
    git stash show -p $stash
}

function gsp {
    if [[ $1 ]]; then
        stash="stash@{$1}"
    else
        stash="stash@{0}"
    fi
    git stash pop $stash
}

function pick {
    git ss && git checkout $1 && gsr && git cherry-pick $2 
}

function git_history_grep {
    git grep $1 $(git rev-list --all)
}

function gce {
    git add -p && git commit -m "polc"
}
# End Git Configs

# Growl
function n {
    "$@"
    growlnotify "Script Completed" -m "$@"
}
# End Growl

function sr {
    perl -pi -w -e "s/$1/$2/g;" $3
}

function man2pdf(){ man -t ${1:?Specify man as arg} | open -f -a preview; }

# Setting PATH for MacPython 2.6
# The orginal version is saved in .bash_profile.pysave
# PATH="/Library/Frameworks/Python.framework/Versions/2.6/bin:${PATH}"
# export PATH

# MacPorts Installer addition on 2010-02-18_at_14:29:20: adding an appropriate PATH variable for use with MacPorts.
# export PATH=/opt/local/bin:/opt/local/sbin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"  # This loads RVM into a shell session.

# startup virtualenv-burrito
. $HOME/.venvburrito/startup.sh

# rbenv
#export PATH="$HOME/.rbenv/bin:$PATH"
#eval "$(rbenv init -)"



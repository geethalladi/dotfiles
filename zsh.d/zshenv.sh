########################################################################################
# Terminal Preferences

# export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\$ "
# export PS1="\[\033[32m\]\h:\[\033[1;37m\]\w\[\033[37m\]\$ "
# export LSCOLORS=ExFxBxDxCxegedabagacad

# Solarized Light theme
# export PS1="\[\033[0;32m\]\u\[\033[0;32m\]@:\[\033[0;32m\]\w\[\033[m\]\$ "
# export CLICOLOR=1

########################################################################################

# Alias definitions
alias c='clear'
alias l='ls -al'
alias ls='ls -GFh'

# Emacs to use cocoa emacs app
alias emacs=/Applications/Emacs.app/Contents/MacOS/Emacs

alias e='ec'

# alias emacsclient to 'ecl'
alias ecl='emacsclient -nw'

alias m='mvn -Dmaven.javadoc.skip=true'
alias g='git'
alias t='tree'
alias pass='openssl rand -base64 16'
alias rg='rvm gemset use'

alias scheme="rlwrap -r -c -f ~/extn.d/mit_scheme_bindings.txt scheme"
alias ghci="ghci -XNPlusKPatterns"
alias hivec="hive -hiveconf hive.root.logger=DEBUG,console"

########################################################################################
# Custom Path Variables

export VISUAL=emacs
export EDITOR=emacs
export GIT_EDITOR=emacsclient

########################################################################################
# Directories

# export TMPDIR=/tmp # Required for emacs TRAMP MODE
export DOTFILES=~/dotfiles
export DOTFILE_DIR_GIT=${DOTFILES}/git.d
export DOTFILE_DIR_AWS=${DOTFILES}/aws.d
export DOTFILE_DIR_RVM=${DOTFILES}/rvm.d
export DOTFILE_DIR_ZSH=${DOTFILES}/zsh.d
export DOTFILE_DIR_TMUX=${DOTFILES}/tmux.d
export DOTFILE_DIR_EMACS=${DOTFILES}/emacs.d

export INSTALL_DIR=~/installed.d
export EXTN_SCRIPTS_DIR=~/extn.d
export ZSHDIR=${DOTFILE_DIR_ZSH}

########################################################################################
# Configuration Parameters

export DEFAULT_USER=${USER} # required for zshell prompt
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Use bash shell in emacs
export ESHELL=zsh # Till I am comfortable with emacs-shell

# Enabling EMACS variable disables line editing in zsh
export EMACS_APP=/Applications/Emacs.app/Contents/MacOS/Emacs

########################################################################################
# Git Configuration

# Manually setting/re-setting git configuration
# ${EXTN_SCRIPTS_DIR}/git-config.sh 'work'
# export GIT_CONFIG=~/.gitconfig

########################################################################################
# PATH Variable
export CELLAR_PATH=/usr/local/Cellar
export CASK_PATH=~/.cask/bin

export COREUTIL_PATH=${CELLAR_PATH}/coreutils/8.24

# export JDK_7_0_HOME=/Library/Java/JavaVirtualMachines/1.7.0.jdk/Contents/Home
# export JDK_7_HOME=/Library/Java/JavaVirtualMachines/jdk1.7.0_75.jdk/Contents/Home
export JDK_8_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_121.jdk/Contents/Home/
export JAVA_HOME=${JDK_8_HOME}

export SCALA_HOME=${CELLAR_PATH}/scala/2.12.1
export SBT_HOME=${CELLAR_PATH}/sbt/0.13.13

export ANT_HOME=${CELLAR_PATH}/ant/1.10.1
export MAVEN_HOME=${CELLAR_PATH}/maven-3.3.9
export M2_HOME=${MAVEN_HOME}
export GRADLE_HOME=${CELLAR_PATH}/gradle/3.3

# Using lein for clojure jar dependencies
# export CLOJURE_VERSION='1.7.0' # will also be used when running clj-repl
# export CLOJURE_HOME="${INSTALL_DIR}/clojure-${CLOJURE_VERSION}"

##### Needs to be updated  ######

export NODE_PATH=/usr/local/lib/node_modules

export HADOOP_HOME=${INSTALL_DIR}/hadoop-2.7.3
export HADOOP_PREFIX=${HADOOP_HOME}
export HIVE_HOME=${INSTALL_DIR}/apache-hive-2.1.1-bin
export SPARK_HOME=${INSTALL_DIR}/spark/spark-2.0.0-bin-hadoop2.7
export SPARK_PREFIX=${SPARK_HOME}
export PYSPARK_DRIVER_PYTHON=ipython  # Use ipython for pyspark

##### Needs to be updated  ######

export ANACONDA2_HOME=${INSTALL_DIR}/anaconda/anaconda
export ANACONDA3_HOME=${INSTALL_DIR}/anaconda3

export HOMEBREW_CASK_OPTS="--appdir=/Applications --caskroom=/usr/local/Caskroom"
export HOMEBREW_NO_ANALYTICS=1

export MACPORT_HOME=/opt/local

export RUBY_SCRIPTS_HOME=~/repo/personal/ruby

export ES_HOME=${INSTALL_DIR}/elasticsearch-1.7.2

export PATH=${PATH}:${EXTN_SCRIPTS_DIR}:${MAVEN_HOME}/bin:${CASK_PATH}:${HASKELL_HOME}/bin:${ANT_HOME}/bin:${GRADLE_HOME}/bin:${RUBY_SCRIPTS_HOME}:${COREUTIL_PATH}/bin:/usr/local/sbin:${HIVE_HOME}/bin:${HADOOP_HOME}/bin:${SPARK_HOME}/bin:${MACPORT_HOME}/bin:${ANACONDA2_HOME}/bin:${ES_HOME}/bin

# Using custom installed java/scala
export PATH=${JAVA_HOME}/bin:${SCALA_HOME}/bin:${PATH}

########################################################################################
# Java Options

export JAVA_OPTS="-Xms256m -Xmx3000m"

# OPAM configuration (for OCaml)
# . ~/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true

## For Terminal inside emacs
if [ -n "$INSIDE_EMACS" ]; then
    # USE emacsclient while inside emacs
    export EDITOR=emacsclient
    export PS1="(%{$fg[cyan]%}%/%{$reset_color%}) ~ "
fi
# Ripper CTAGS for rvm
# export RIPPER_TAGS_EMACS=1

function show() {
    echo "rvm: "`rvm-prompt`
    echo "git branch: "`git_current_branch`
    git-config.sh
}
alias shw='show'

# for tmuxinator
# source ${DOTFILE_DIR_TMUX}/tmuxinator.zsh

source ${DOTFILE_DIR_AWS}/awsenv.sh

source ${ZSHDIR}/macports.sh

# RVM should be the final one
source ${DOTFILE_DIR_RVM}/rvm.sh

# Not the best of all hacks
# Use a directory specific gemset or fallback to default gemset
cd /tmp; cd -

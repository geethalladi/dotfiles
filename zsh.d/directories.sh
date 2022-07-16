########################################################################################
# Directories
########################################################################################

# export TMPDIR=/tmp # Required for emacs TRAMP MODE
export DOTFILES=~/dotfiles
export DOTFILE_DIR_ZSH=${DOTFILES}/zsh.d
export DOTFILE_DIR_GIT=${DOTFILES}/git.d
export DOTFILE_DIR_AWS=${DOTFILES}/aws.d
export DOTFILE_DIR_RVM=${DOTFILES}/rvm.d
export DOTFILE_DIR_TMUX=${DOTFILES}/tmux.d
export DOTFILE_DIR_EMACS=${DOTFILES}/emacs.d

export INSTALL_DIR=~/installed.d
export EXTN_SCRIPTS_DIR=~/extn.d
export ZSHDIR=${DOTFILE_DIR_ZSH}
export LOCAL_BIN_DIR=~/.local/bin

# private / project
export PRIVATE_DIR=~/private
export PROJECT_DIR=${PRIVATE_DIR}/projects

########################################################################################
# For PATH Variable
########################################################################################

export CELLAR_PATH=/usr/local/Cellar
export CASK_PATH=~/.cask/bin
export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig

export COREUTIL_PATH=${CELLAR_PATH}/coreutils/8.24

# Using sdkman for jvm languages
# export JDK_7_0_HOME=/Library/Java/JavaVirtualMachines/1.7.0.jdk/Contents/Home
# export JDK_7_HOME=/Library/Java/JavaVirtualMachines/jdk1.7.0_75.jdk/Contents/Home
# export JDK_8_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_121.jdk/Contents/Home
# export JDK_13_HOME=/Library/Java/JavaVirtualMachines/jdk-13.0.1.jdk/Contents/Home
# export JAVA_HOME=${JDK_8_HOME}

# export SCALA_HOME=${CELLAR_PATH}/scala/2.12.1
# export SBT_HOME=${CELLAR_PATH}/sbt/0.13.13
# export CONSCRIPT_HOME=${INSTALL_DIR}/conscript

export ANT_HOME=${CELLAR_PATH}/ant/1.10.1
# export MAVEN_HOME=${CELLAR_PATH}/maven/3.3.9
# export M2_HOME=${MAVEN_HOME}
export GRADLE_HOME=${CELLAR_PATH}/gradle/3.4.1
export CABAL_HOME=~/.cabal
export SDKMAN_DIR=${HOME}/.sdkman

##### Needs to be updated  ######
# Using lein for clojure jar dependencies
# export CLOJURE_VERSION='1.7.0' # will also be used when running clj-repl
# export CLOJURE_HOME="${INSTALL_DIR}/clojure-${CLOJURE_VERSION}"

# nvm does not like NODE_PATH
# export NODE_PATH=/usr/local/lib/node_modules

export HADOOP_HOME=${INSTALL_DIR}/hadoop-2.7.3
export HADOOP_PREFIX=${HADOOP_HOME}
export HIVE_HOME=${INSTALL_DIR}/apache-hive-2.1.1-bin
export SPARK_HOME=${INSTALL_DIR}/spark/spark-1.6.2-bin-hadoop2.6

export SPARK_PREFIX=${SPARK_HOME}

export MACPORT_HOME=/opt/local
export HOMEBREW_HOME=/opt/homebrew

export RUBY_SCRIPTS_HOME=${PROJECT_DIR}/ruby
export PYTHON_MOD_UTILS=${PROJECT_DIR}/python/modules
export PYTHON_PATH_FILE=~/.pythonpath

export ES_HOME=${INSTALL_DIR}/elasticsearch-5.6.16
export ERLANG_ROOT_DIR=${CELLAR_PATH}/erlang/20.3.4
export ERLANG_HOME=${ERLANG_ROOT_DIR}

export LIQUIBASE_HOME=/usr/local/opt/liquibase/libexec
export FIREFOX_HOME=/Applications/Firefox.app/Contents/MacOS

export OPAM_DIR=${HOME}/.opam
export BABASHKA_CLASSPATH=.

export TMUXP_CONFIGDIR=${PROJECT_DIR}/tmux
export DOOMDIR=${INSTALL_DIR}/doom-emacs

# Adding GO related paths
# export GOROOT=/usr/local/opt/go
export GOPATH=~/repo/open-source/goprojects

# Enabling EMACS variable disables line editing in zsh
export EMACS_APP=/Applications/Emacs.app
export ZEAL_HOME=/Applications/Zeal.app

# For faster traversal
export JOURNAL_DIR=${PRIVATE_DIR}/journals
export FINANCE_DIR=${PRIVATE_DIR}/finance
export INVESTING_DIR=${FINANCE_DIR}/investing
export DOCS_DIR=${PRIVATE_DIR}/documents

# where I write stuff
export WRITING_DIR=${PRIVATE_DIR}/writing
export MEETING_DIR=${WRITING_DIR}/meeting
export EMAIL_DIR=${WRITING_DIR}/email

#!/usr/bin/env zsh

########################################################################################
# PATH Configurations
########################################################################################

## for tmux always update the PATH
if [[ "$PATH_STATE_UPDATED" != "1" || ${TERM_PROGRAM} == "tmux" ]]; then
    PATH=${CASK_PATH}:${COREUTIL_PATH}/bin:${CARGO_PATH}:${CONSCRIPT_HOME}/bin:${CABAL_HOME}/bin:${PATH}:${RUBY_SCRIPTS_HOME}:${ANT_HOME}/bin:${GRADLE_HOME}/bin:${HASKELL_HOME}/bin:${ES_HOME}/bin:${EXTN_SCRIPTS_DIR}:${MAVEN_HOME}/bin:${GOROOT}/bin

    # export PATH=${PATH}:${HADOOP_HOME}/bin:${HIVE_HOME}/bin:${SPARK_HOME}/bin

    # Using custom installed java/scala
    PATH=${GOPATH}/bin:${PATH}
    PATH=${PATH}:${LOCAL_BIN_DIR}:/usr/local/sbin
    PATH=${PATH}:${HOME}/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin
    PATH=${PATH}:${INSTALL_DIR}
    PATH=${PATH}:/usr/local/opt/mysql@5.7/bin:/usr/local/opt/mysql-client/bin
    # PATH=${PATH}:${HOME}/Library/Python/3.9/bin
    PATH=${PATH}:${ZEAL_HOME}/Contents/MacOS:${DOOM_EMACS_DIR}/bin
    PATH=${HOMEBREW_HOME}/bin:${HOMEBREW_HOME}/sbin:${PATH}
    PATH=${PATH}:${OPEN_SOURCE_DIR}/powerline/scripts
    PATH=${HOMEBREW_HOME}/opt/python@3.8/bin:${HOMEBREW_HOME}/opt/qt/bin:${PATH}

    # PATH="/usr/local/bin:${PATH}"

    # source ${DOTFILE_DIR_AWS}/awsenv.sh
    # source ${ZSHDIR}/macports.sh

    if [[ ${TERM_PROGRAM} != "iTerm.app" &&
        ${TERM_PROGRAM} != "tmux" &&
        ${TERM} != "eterm-color" &&
        ${TERM} != "dumb" ]]; then
        source ${DOTFILE_DIR_ZSH}/xvm.sh
    fi

    # Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
    PATH="$PATH:$HOME/.rvm/bin"
    export MANPATH="/usr/local/man:$MANPATH"

    # export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk-11.0.15.jdk/Contents/Home
    # export PATH=${JAVA_HOME}/bin:${PATH}
    PATH=${PATH}:${FIREFOX_HOME}

    export PATH

    # Rehash to take care of the PATH variable update
    # https://stackoverflow.com/questions/36543707/why-does-zsh-ignore-the-path-entry-order
    rehash

    # Dont update once everything is in place
    export PATH_STATE_UPDATED=1
fi

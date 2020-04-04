#!/usr/bin/env zsh

########################################################################################
# PATH Configurations
########################################################################################

if [ "$PATH_STATE_UPDATED" != "1" ]; then
    export PATH=${CASK_PATH}:${COREUTIL_PATH}/bin:${CONSCRIPT_HOME}/bin:${CABAL_HOME}/bin:${CONDA_HOME}/bin:${PATH}:${RUBY_SCRIPTS_HOME}:${ANT_HOME}/bin:${GRADLE_HOME}/bin:${HASKELL_HOME}/bin:${ES_HOME}/bin:${EXTN_SCRIPTS_DIR}:${MAVEN_HOME}/bin:${GOROOT}/bin

    # export PATH=${PATH}:${HADOOP_HOME}/bin:${HIVE_HOME}/bin:${SPARK_HOME}/bin

    # Using custom installed java/scala
    export PATH=${JAVA_HOME}/bin:${SCALA_HOME}/bin:${PATH}
    export PATH=${PATH}:${LOCAL_BIN_DIR}:/usr/local/opt/mysql@5.6/bin/:/usr/local/sbin
    export PATH=${PATH}:${HOME}/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin
    # export PATH="/usr/local/bin:${PATH}"

    # for tmuxinator
    # source ${DOTFILE_DIR_TMUX}/tmuxinator.zsh

    # source ${DOTFILE_DIR_AWS}/awsenv.sh
    # source ${ZSHDIR}/macports.sh

    if [[ ${TERM_PROGRAM} != "iTerm.app" && ${TERM} != "eterm-color" && ${TERM} != "dumb" ]]; then
        source ${DOTFILE_DIR_ZSH}/xvm.sh
    fi

    # Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
    export PATH="$PATH:$HOME/.rvm/bin"
    export MANPATH="/usr/local/man:$MANPATH"

    # Rehash to take care of the PATH variable update
    # https://stackoverflow.com/questions/36543707/why-does-zsh-ignore-the-path-entry-order
    rehash

    # Dont update once everything is in place
    export PATH_STATE_UPDATED=1
fi

#!/usr/bin/env zsh

########################################################################################
# PATH Configurations
########################################################################################

if [ "$PATH_STATE_UPDATED" != "1" ]; then
    export PATH=${CASK_PATH}:${COREUTIL_PATH}/bin:${CONSCRIPT_HOME}/bin:${CABAL_HOME}/bin:${PATH}:${CONDA_HOME}/bin:${RUBY_SCRIPTS_HOME}:${ANT_HOME}/bin:${GRADLE_HOME}/bin:${HASKELL_HOME}/bin:${ES_HOME}/bin:${EXTN_SCRIPTS_DIR}:${MAVEN_HOME}/bin:${GOROOT}/bin

    # export PATH=${PATH}:${HADOOP_HOME}/bin:${HIVE_HOME}/bin:${SPARK_HOME}/bin

    # Using custom installed java/scala
    export PATH=${GOPATH}/bin:${PATH}
    export PATH=${PATH}:${LOCAL_BIN_DIR}:/usr/local/sbin
    export PATH=${PATH}:${HOME}/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin
    export PATH=${PATH}:${INSTALL_DIR}
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

    # THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
    [[ -s "${SDKMAN_DIR}/bin/sdkman-init.sh" ]] && source "${SDKMAN_DIR}/bin/sdkman-init.sh"

    # Rehash to take care of the PATH variable update
    # https://stackoverflow.com/questions/36543707/why-does-zsh-ignore-the-path-entry-order
    rehash

    # Dont update once everything is in place
    export PATH_STATE_UPDATED=1
fi

########################################################################################
# PATH Configurations

if [ "$PATH_STATE_UPDATED" -ne 1 ]; then
    export PATH=${EXTN_SCRIPTS_DIR}:${MAVEN_HOME}/bin:${CASK_PATH}:${HASKELL_HOME}/bin:${ANT_HOME}/bin:${GRADLE_HOME}/bin:${RUBY_SCRIPTS_HOME}:${COREUTIL_PATH}/bin:/usr/local/sbin:${HIVE_HOME}/bin:${HADOOP_HOME}/bin:${SPARK_HOME}/bin:${MACPORT_HOME}/bin:${ANACONDA2_HOME}/bin:${ES_HOME}/bin:${CONSCRIPT_HOME}/bin:${CABAL_HOME}/bin:${GOROOT}/bin:${PATH}

    # Using custom installed java/scala
    export PATH=${JAVA_HOME}/bin:${SCALA_HOME}/bin:${PATH}
    export PATH=${PATH}:${LOCAL_BIN_DIR}:/usr/local/opt/mysql@5.6/bin/

    # for tmuxinator
    # source ${DOTFILE_DIR_TMUX}/tmuxinator.zsh

    # source ${DOTFILE_DIR_AWS}/awsenv.sh
    # source ${ZSHDIR}/macports.sh

    # Dont update once everything is in place
    export PATH_STATE_UPDATED=1
fi

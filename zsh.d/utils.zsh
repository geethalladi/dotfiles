#!/bin/zsh

# init sdk man
sdkinit () {
    if [[ -s "${SDKMAN_DIR}/bin/sdkman-init.sh" ]]; then
        source ${SDKMAN_DIR}/bin/sdkman-init.sh
    fi
}

# Elasticsearch function [start | stop]
elasticsearch () {
    CMD=${1:-"start"}
    if [[ ${CMD} = "stop" ]]; then
        # kill the process with the given pid
        pkill -F ${ES_HOME}/pidfile
    else
        # run in daemon mode with pidfile
        ${ES_HOME}/bin/elasticsearch -d -p ${ES_HOME}/pidfile
    fi
}

emacspipe () {
    file=$(mktemp)

    while IFS= read -r line || [ -n "$line" ]; do
        printf '%s\n' "$line"
    done > ${file}

    # Open the temporary file in Emacs
    e $file
}

generate_ripper_tags () {
    ripper-tags -R -f TAGS
}

conda_init () {
    # >>> conda initialize >>>
    # !! Contents within this block are managed by 'conda init' !!
    __conda_setup="$('/usr/local/Caskroom/miniconda/base/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    else
        if [ -f "/usr/local/Caskroom/miniconda/base/etc/profile.d/conda.sh" ]; then
            . "/usr/local/Caskroom/miniconda/base/etc/profile.d/conda.sh"
        else
            export PATH="/usr/local/Caskroom/miniconda/base/bin:$PATH"
        fi
    fi
    unset __conda_setup
    # <<< conda initialize <<<
}

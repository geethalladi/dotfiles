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

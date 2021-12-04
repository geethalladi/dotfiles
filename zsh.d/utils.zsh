#!/bin/zsh

# init sdk man
sdkinit () {
    if [[ -s "${SDKMAN_DIR}/bin/sdkman-init.sh" ]]; then
        source ${SDKMAN_DIR}/bin/sdkman-init.sh
    fi
}

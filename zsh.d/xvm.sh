which nvm > /dev/null
if [ "$?" != 0 ]; then
    echo "Sourcing version managers"

    # Go Version manager
    # source ~/.gvm/scripts/gvm

    # nvm
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    # nvm use 8;

    # rvm
    source ${DOTFILE_DIR_RVM}/rvm.sh

    # sdkman
    export SDKMAN_DIR="${HOME}/.sdkman"
    [[ -s "${SDKMAN_DIR}/bin/sdkman-init.sh" ]] && source "${SDKMAN_DIR}/bin/sdkman-init.sh"

    export XVM_INIT_COMPLETE=1
fi

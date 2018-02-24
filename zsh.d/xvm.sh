# echo "Sourcing nvm/rvm/gvm scripts..."
# Updating the path here after zshrc

if [ "${XVM_INIT_COMPLETE}" != 1 ]; then
    echo "Sourcing version managers"

    # Go Version manager
    source ~/.gvm/scripts/gvm

    # nvm
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    nvm use 8;

    # rvm
    source ${DOTFILE_DIR_RVM}/rvm.sh

    export XVM_INIT_COMPLETE=1
fi

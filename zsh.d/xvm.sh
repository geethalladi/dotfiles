which rvm > /dev/null
if [ "$?" != 0 ]; then
    echo "Sourcing version managers"

    # Go Version manager
    # source ~/.gvm/scripts/gvm

    # nvm
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    # [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
    # [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
    # nvm use 8;

    # rvm
    source ${DOTFILE_DIR_RVM}/rvm.sh

    # Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
    export PATH="$PATH:$HOME/.rvm/bin"

    export XVM_INIT_COMPLETE=1
fi

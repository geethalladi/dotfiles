# echo "Sourcing nvm/rvm/gvm scripts..."
# Updating the path here after zshrc

if [[ ! -v GVM_VERSION ]]; then
    echo "Sourcing gvm scripts..."
    source ~/.gvm/scripts/gvm
fi

# NVM PATH
if [[ ! -v NVM_DIR ]]; then
    echo "Sourcing nvm scripts..."
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
fi

# RVM should be the final one
if [[ ! -v rvm_version ]]; then
    echo "Sourcing rvm scripts..."
    source ${DOTFILE_DIR_RVM}/rvm.sh
fi

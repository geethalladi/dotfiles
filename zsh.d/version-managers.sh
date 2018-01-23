echo "Sourcing nvm/rvm/gvm scripts..."
# Updating the path here after zshrc
source ~/.gvm/scripts/gvm

# NVM PATH
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

# RVM should be the final one
source ${DOTFILE_DIR_RVM}/rvm.sh

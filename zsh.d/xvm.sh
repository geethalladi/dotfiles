# echo "Sourcing nvm/rvm/gvm scripts..."
# Updating the path here after zshrc

echo "Sourcing version managers"

source ~/.gvm/scripts/gvm

# This loads nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

source ${DOTFILE_DIR_RVM}/rvm.sh

# GVM_PATH=$(which gvm)
# if [[ ${GVM_PATH} == "gvm not found" ]]; then
#     source ~/.gvm/scripts/gvm
# fi

# NVM_PATH=$(which nvm)
# if [[ ${NVM_PATH} == "nvm not found" ]]; then
#     export NVM_DIR="$HOME/.nvm"
#     [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# fi

# # RVM should be the final one
# RVM_PATH=$(which rvm)
# if [[ ${RVM_PATH} == "rvm not found" ]]; then
#     source ${DOTFILE_DIR_RVM}/rvm.sh
# fi

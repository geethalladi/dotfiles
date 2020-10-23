########################################################################################
# Terminal Preferences

# export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\$ "
# export PS1="\[\033[32m\]\h:\[\033[1;37m\]\w\[\033[37m\]\$ "
# export LSCOLORS=ExFxBxDxCxegedabagacad

# Solarized Light theme
# export PS1="\[\033[0;32m\]\u\[\033[0;32m\]@:\[\033[0;32m\]\w\[\033[m\]\$ "
# export CLICOLOR=1

########################################################################################
# Editor Configuration
########################################################################################

export EDITOR=emacsclient
export VISUAL=emacsclient
export GIT_EDITOR=emacsclient
# Specify the version of emacs to use for cask
export EMACS_VERSION=26.2
export EMACS="/usr/local/bin/emacs"

########################################################################################
# Configuration Parameters
########################################################################################

export DEFAULT_USER=${USER} # required for zshell prompt
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Use bash shell in emacs
export ESHELL=zsh # Till I am comfortable with emacs-shell

########################################################################################
# Git Configuration
########################################################################################

# Manually setting/re-setting git configuration
# ${EXTN_SCRIPTS_DIR}/git-config.sh 'work'
# export GIT_CONFIG=~/.gitconfig

########################################################################################
# Directories Configuration
########################################################################################

export DOTFILES=~/dotfiles
source ${DOTFILES}/zsh.d/directories.sh

########################################################################################
# Spark Configuration
########################################################################################

# For Spark < 2.0
export IPYTHON=1
export IPYTHON_OPTS="notebook"

# For Spark >= 2.0
# export PYSPARK_DRIVER_PYTHON=jupyter
# export PYSPARK_DRIVER_PYTHON_OPTS="notebook"

##### Needs to be updated  ######

export HOMEBREW_CASK_OPTS="--appdir=/Applications"
export HOMEBREW_NO_ANALYTICS=1

########################################################################################
# Java Options
########################################################################################

export JAVA_OPTS="-Xms256m -Xmx3000m"

# OPAM configuration (for OCaml)
# . ~/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true

## For Terminal inside emacs
if [ -n "$INSIDE_EMACS" ]; then
    # USE emacsclient while inside emacs
    export EDITOR=emacsclient
    export PS1="(%{$fg[cyan]%}%/%{$reset_color%}) ~ "
fi

## For any dumb terminal
[[ $TERM == "dumb" || $TERM == "tramp" ]] && unsetopt zle && PS1='$ '

########################################################################################
# Importing Custom Python Modules
########################################################################################

export PYTHONPATH=${PYTHONPATH}:${PYTHON_MOD_UTILS}

# Add all the python projects to the PYTHONPATH
if ls ${PYTHON_PATH_FILE} 1> /dev/null 2>&1; then
    source ${PYTHON_PATH_FILE}
fi

source ${CONDA_HOME}/etc/profile.d/conda.sh

########################################################################################
# OCaml / opam configuration
########################################################################################

export OPAM_DIR=${HOME}/.opam
test -r ${OPAM_DIR}/opam-init/init.zsh && . ${OPAM_DIR}/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

########################################################################################
# iterm zsh integration (only in iterm2)
########################################################################################

if [ -n "$ITERM_SESSION_ID" ]; then
    test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
fi

source ${DOTFILES}/zsh.d/alias.sh
source ${DOTFILES}/dayjob.d/*.sh

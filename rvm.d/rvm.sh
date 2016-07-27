# RVM Installation

# This function definition is required by rvm

shell_session_update() { :; }

# USING THE DEFAULT GEMSET WHILE LOGGING IN
export GEM_HOME=~/.rvm/gems/ruby-2.3.0
export GEM_PATH=~/.rvm/gems/ruby-2.3.0
export PATH="${GEM_HOME}/bin:$HOME/.rvm/bin:${PATH}" # Add RVM to PATH for scripting

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
[[ -r $rvm_path/scripts/completion ]] && . $rvm_path/scripts/completion

rvm default

# # Not required if a gemset is marked as --default
rvm use default@zz-junk --default

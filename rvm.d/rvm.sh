# RVM Installation

# This function definition is required by rvm

shell_session_update() { :; }

# USING THE DEFAULT GEMSET WHILE LOGGING IN
export GEM_HOME=~/.rvm/gems/ruby-2.2.3
export GEM_PATH=~/.rvm/gems/ruby-2.2.3

export PATH="${GEM_HOME}/bin:$HOME/.rvm/bin:${PATH}" # Add RVM to PATH for scripting

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

rvm default
rvm use default@zz-junk; echo # ECHO TO PRINT A NEWLINE AT THE END

[[ -r $rvm_path/scripts/completion ]] && . $rvm_path/scripts/completion

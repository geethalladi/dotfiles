# ==============================
#   .pryrc
# ==============================

require 'rubygems'

require 'pry'
require 'pry-byebug'
require 'pry-clipboard'
require 'pry-doc'
require 'pry-nav'
require 'pry-stack_explorer'
require 'pry-rescue'
require 'pry-rails'

# needed for emacs pry integration
Pry.config.auto_indent = false

if Pry::Prompt[:rails]
  Pry.config.prompt = Pry::Prompt[:rails]
end

Pry.commands.alias_command 'c', 'continue'
Pry.commands.alias_command 's', 'step'
Pry.commands.alias_command 'n', 'next'
Pry.commands.alias_command 'h', 'help'

# Updates from https://github.com/JuanitoFatas/dotpryrc/blob/master/.pryrc

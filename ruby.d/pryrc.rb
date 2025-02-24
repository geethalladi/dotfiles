# ==============================
#   .pryrc
# ==============================

require 'rubygems'

require 'pry'
require 'pry-doc'
require 'pry-byebug'
require 'pry-rails'

# review later
# require 'pry-clipboard'
# require 'pry-rescue'

# not compatible with pry-byebug
# require 'pry-nav'
# require 'pry-stack_explorer'

# needed for emacs pry integration
Pry.config.auto_indent = false

if Pry::Prompt[:rails]
  Pry.config.prompt = Pry::Prompt[:rails]
end

if defined?(PryByebug)
  Pry.commands.alias_command 'c', 'continue'
  Pry.commands.alias_command 's', 'step'
  Pry.commands.alias_command 'n', 'next'
  Pry.commands.alias_command 'f', 'finish'
end

# Hit Enter to repeat last command
Pry::Commands.command(/^$/, "repeat last command") do
  pry_instance.run_command Pry.history.to_a.last
end

# Updates from https://github.com/JuanitoFatas/dotpryrc/blob/master/.pryrc

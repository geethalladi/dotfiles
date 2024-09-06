# ==============================
#   .pryrc
# ==============================

Pry.config.auto_indent = false

if Pry::Prompt[:rails]
  Pry.config.prompt = Pry::Prompt[:rails]
end

# Updates from https://github.com/JuanitoFatas/dotpryrc/blob/master/.pryrc
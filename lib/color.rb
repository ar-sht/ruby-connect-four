CLEAR   = "\e[0m".freeze
BOLD    = "\e[1m".freeze

# Colors
BLACK   = "\e[30m".freeze
RED     = "\e[31m".freeze
GREEN   = "\e[32m".freeze
YELLOW  = "\e[33m".freeze
BLUE    = "\e[34m".freeze
MAGENTA = "\e[35m".freeze
CYAN    = "\e[36m".freeze
WHITE   = "\e[37m".freeze

def color(text, color, bold=false)
  color = self.class.const_get(color.to_s.upcase) if color.is_a?(Symbol)
  bold  = bold ? BOLD : ""
  "#{bold}#{color}#{text}#{CLEAR}"
end

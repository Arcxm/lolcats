COLOR_RESET = "\x1B[0m"
FREQ = 0.1

class Rgb
  attr_reader :r, :g, :b

  def initialize(r, g, b)
    @r = r
    @g = g
    @b = b
  end

  def self.rainbow(frequency, i)
    r = (Math.sin(frequency * i) * 127 + 128).floor
    g = (Math.sin(frequency * i + 2 * Math::PI / 3) * 127 + 128).floor
    b = (Math.sin(frequency * i + 4 * Math::PI / 3) * 127 + 128).floor
  
    Rgb.new(r, g, b)
  end
end

def putc_with_rgb(c, color)
  print "\x1B[38;2;%d;%d;%dm%c%s" % [color.r, color.g, color.b, c, COLOR_RESET]
end

if ARGV.length > 0
  input = ARGV[0]

  for i in 0...input.length do
    putc_with_rgb(input[i], Rgb.rainbow(FREQ, i))
  end
end

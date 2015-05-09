class Debris

  # attr_reader :x, :y,

  def initialize(window, x, y, debris_type)
    @x, @y = x, y
    @image = Gosu::Image.load_tiles(window, 'media/debris_rocks.png', 58, 60, true)
    @debris_tile = debris_type

  end

  def draw()
    @image[@debris_tile].draw(@x, @y, 1)
  end

end
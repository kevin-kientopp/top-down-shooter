class Debris

  # attr_reader :x, :y,

  def initialize(image, x, y, debris_type)
    @x, @y = x, y
    @image = image
    @debris_tile = debris_type

  end

  def draw()
    @image[@debris_tile].draw(@x, @y, 1)
  end

end
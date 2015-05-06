class Tile
  def initialize(x, y, image)
    @x, @y, @image = x, y, image
  end

  def draw
    @image.draw_rot(@x, @y, 0, 0)
  end
end

class Tile
  WIDTH = 100
  HEIGHT = 100

  def initialize(x, y, image)
    @x, @y, @image = x, y, image
  end

  def draw
    @image.draw_rot(@x, @y, 0, 0)
  end
end

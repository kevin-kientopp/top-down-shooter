class Enemy
  def initialize(x, y, image)
    @x, @y, @image = x, y, image
    @player_tile = 0
    @angle = 0
  end

  def draw
    @image[@player_tile].draw_rot(@x, @y, 1, @angle)
  end
end

class Player
  VELOCITY = 1

  attr_reader :x, :y, :angle

  def initialize(window, image)
    @image = image
    @x = @y = 0.0
    @angle = 0.0
  end

  def draw
    @image.draw_rot(@x, @y, 1, @angle)
  end

  def warp(x, y)
    @x, @y = x, y
  end

  def move_up
    @y -= VELOCITY
    @angle = 180.0
  end

  def move_down
    @y += VELOCITY
    @angle = 0.0
  end

  def move_left
    @x -= VELOCITY
    @angle = 90.0
  end

  def move_right
    @x += VELOCITY
    @angle = 270.0
  end
end

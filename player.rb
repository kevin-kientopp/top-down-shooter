class Player
  VELOCITY = 3

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
    @y -= 1
    @angle = 180.0
  end

  def move_down
    @y += 1
    @angle = 0.0
  end

  def move_left
    @x -= 1
    @angle = 90.0
  end

  def move_right
    @x += 1
    @angle = 270.0
  end
end

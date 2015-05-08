class Bullet
  VELOCITY = 2

  def initialize(x, y, angle, image)
    @x, @y, @angle, @image = x, y, angle, image
  end

  def draw
    @image.draw_rot(@x, @y, 1, @angle)
  end

  def move
    case @angle
    when 0 #down
      @y += VELOCITY
    when 90 #left
      @x -= VELOCITY
    when 180 #up
      @y -= VELOCITY
    when 270 #right
      @x += VELOCITY
    end
  end
end

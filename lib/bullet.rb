class Bullet
  VELOCITY = 2

  attr_reader :x, :y

  def initialize(x, y, angle, image)
    @x, @y, @angle, @image = x, y, angle, image
  end

  def draw
    @image.draw_rot(@x, @y, 1, @angle)
  end

  def move
    case @angle
    when 0 #up
      @y -= VELOCITY
    when 90 #right
      @x += VELOCITY
    when 180 #down
      @y += VELOCITY
    when 270 #left
      @x -= VELOCITY
    end
  end
end

require 'gosu'

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
    @x += Gosu.offset_x(@angle, VELOCITY)
    @y += Gosu.offset_y(@angle, VELOCITY)  
  end
end

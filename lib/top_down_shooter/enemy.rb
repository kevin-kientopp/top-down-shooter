require 'gosu'

class Enemy
  attr_accessor :angle, :shot_cooldown
  attr_reader :x, :y

  def initialize(x, y, angle, image, bullet_image)
    @x, @y, @angle, @image, @bullet_image = x, y, angle, image, bullet_image
    @player_tile = 0
    @shot_cooldown = 0
  end

  def draw
    @image[@player_tile].draw_rot(@x, @y, 1, @angle)
  end

  def is_aware_of?(player)
    return true if Gosu.distance(@x, @y, player.x, player.y) < 250
    return false
  end

  def turn_towards(player)
    diff = Gosu.angle_diff(@angle, Gosu.angle(@x, @y, player.x, player.y))

    if diff < 0
      @angle += [diff, -2].max
    else
      @angle += [diff, 2].min
    end
  end

  def shoot
    @shot_cooldown = 60
    x, y = calculate_bullet_start_position
    return Bullet.new(x, y, @angle, @bullet_image)
  end

  private
  def calculate_bullet_start_position
    y_offset = -15
    x_offset = -5

    x, y = @x + x_offset, @y + y_offset

    x, y = rotate(x, -y, @x, -@y, @angle)

    return x, y
  end

  def rotate(x, y, origin_x, origin_y, angle)
    p_x = x
    p_y = y

    s = Math.sin(angle * Math::PI / 180.0)
    c = Math.cos(angle * Math::PI / 180.0)

    # translate point back to origin:
    p_x -= origin_x
    p_y -= origin_y

    # rotate point
    xnew = p_x * c + p_y * s
    ynew = -p_x * s + p_y * c

    # translate point back:
    p_x = xnew + origin_x
    p_y = -ynew - origin_y

    return p_x, p_y
  end
end

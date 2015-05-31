class GunWielder
  def initialize(bullet_image = nil)
    @bullet_image = bullet_image
  end

  def shoot
    x, y = calculate_bullet_start_position
    return Bullet.new(x, y, @angle, @bullet_image, self)
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

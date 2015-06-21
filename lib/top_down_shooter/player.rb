require_relative 'gun_wielder'

class Player < GunWielder
  VELOCITY = 1
  FRAME_DELAY = 100 # ms

  attr_reader :x, :y, :angle
  attr_accessor :dying_timer

  def initialize(image = nil, bullet_image = nil, dying_image = nil)
    super bullet_image
    @player_tile = 0
    @image = image
    @x = @y = 0.0
    @angle = 0.0
    @dying_image = dying_image
    @dying_timer = 0
  end

  def draw
    if dying?
      @dying_image.draw_rot(@x, @y, 1, @angle) unless @dying_timer % 20 > 10
    else
      @image[@player_tile].draw_rot(@x, @y, 1, @angle)
    end
  end

  def warp(x, y)
    @x, @y = x, y
  end

  def move_up(debris)
    @y -= VELOCITY unless collide_with?(debris)
    @angle = 0.0
    alternate_index if frame_expired?
  end

  def move_down(debris)
    @y += VELOCITY unless collide_with?(debris)
    @angle = 180.0
    alternate_index if frame_expired?
  end

  def move_left(debris)
    @x -= VELOCITY unless collide_with?(debris)
    @angle = 270.0
    alternate_index if frame_expired?
  end

  def move_right(debris)
    @x += VELOCITY unless collide_with?(debris)
    @angle = 90.0
    alternate_index if frame_expired?
  end

  def collide_with?(debris)
    debris.flatten.each do |singleDebris|
      if Gosu::distance(@x + middle_width, @y + middle_height, singleDebris.x + singleDebris.middle_width, singleDebris.y + singleDebris.middle_height) < 25
        return true
      end
    end
    false
  end

  def frame_expired?
    now = Gosu.milliseconds
    @last_frame ||= now
    if (now - @last_frame) > FRAME_DELAY
      @last_frame = now
    end
  end

  def alternate_index
    if @player_tile == 0
      @player_tile = 1
    else
      @player_tile = 0
    end
  end

  def dying?
    @dying_timer > 0
  end

  def middle_width
    @image[@player_tile].width / 2
  end


  def middle_height
    @image[@player_tile].height / 2
  end

end

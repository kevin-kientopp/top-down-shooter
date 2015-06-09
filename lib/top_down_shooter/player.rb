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

  def move_up
    @y -= VELOCITY
    @angle = 0.0
    alternate_index if frame_expired?
  end

  def move_down
    @y += VELOCITY
    @angle = 180.0
    alternate_index if frame_expired?
  end

  def move_left
    @x -= VELOCITY
    @angle = 270.0
    alternate_index if frame_expired?
  end

  def move_right
    @x += VELOCITY
    @angle = 90.0
    alternate_index if frame_expired?
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

end

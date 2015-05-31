require_relative 'gun_wielder'

class Player < GunWielder
  VELOCITY = 1
  FRAME_DELAY = 100 # ms

  attr_reader :x, :y, :angle

  def initialize(image = nil, bullet_image = nil)
    super bullet_image
    @player_tile = 0
    @image = image
    @x = @y = 0.0
    @angle = 0.0
  end

  def draw
    @image[@player_tile].draw_rot(@x, @y, 1, @angle)
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

end

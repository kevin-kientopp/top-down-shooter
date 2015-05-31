require 'gosu'
require_relative 'player'
require_relative 'level'
require_relative 'bullet'
require_relative 'enemy'

class Window < Gosu::Window
  WIDTH = 640
  HEIGHT = 480

  attr_reader :bullets, :player, :enemies
  attr_accessor :sounds_enabled

  def initialize
    super WIDTH, HEIGHT, false
    self.caption = 'Sexy Vampire Shooter'

    @sounds_enabled = true

    @player = Player.new(Gosu::Image.load_tiles(self, 'media/player.png', 16, 21, true))
    @player.warp(Level::WIDTH/2.0, Level::HEIGHT/2.0)

    tile_images = Array.new
    tile_images.push Gosu::Image.new(self, 'media/tile.png', true)
    tile_images.push Gosu::Image.new(self, 'media/tile2.png', true)

    debris_images = Gosu::Image.load_tiles(self, 'media/debris_rocks.png', 58, 60, true)

    @level = Level.new tile_images, debris_images

    @bullet_image = Gosu::Image.new(self, 'media/bullet.png', true)
    @bullets = Array.new

    @gun_sample = Gosu::Sample.new(self, 'media/Colt1911_1.ogg')

    enemy_image = Gosu::Image.load_tiles(self, 'media/enemy.png', 16, 21, true)
    @enemies = Array.new
    @enemies.push Enemy.new(@player.x, @player.y - 200, 180, enemy_image, @bullet_image)

    @s_key_held_down = false

    @font = Gosu::Font.new(20)
    @sounds_status_timer = 0
  end

  def update
    @sounds_status_timer -= 1 if @sounds_status_timer > 0

    @player.move_left if button_down? Gosu::KbLeft unless @player.x < 0
    @player.move_right if button_down? Gosu::KbRight unless @player.x > Level::WIDTH
    @player.move_up if button_down? Gosu::KbUp unless @player.y < 0
    @player.move_down if button_down? Gosu::KbDown unless @player.y > Level::HEIGHT
    @bullets.each { |b| b.move }

    @enemies.each do |e|
      if e.is_aware_of? player
        e.turn_towards player
        if (e.shot_cooldown <= 0)
          @bullets << e.shoot
        else
          e.shot_cooldown -= 1
        end
      end
    end

    if (Gosu::button_down? Gosu::KbLeftControl or Gosu::button_down? Gosu::KbRightControl) and Gosu::button_down? Gosu::KbS and !s_key_held_down? then
      @s_key_held_down = true
      @sounds_enabled = !@sounds_enabled
      @sounds_status_timer = 120
    end
  end

  def draw
    @font.draw("Sound " + (sounds_enabled? ? "enabled" : "disabled"), 10, 10, 3, 1.0, 1.0, 0xff_ffff00) if @sounds_status_timer > 0

    translate(calculate_camera_translation(@player.x, WIDTH, Level::WIDTH), calculate_camera_translation(@player.y, HEIGHT, Level::HEIGHT)) do
      @player.draw
      @level.draw(@bullets)
      @bullets.each { |e| e.draw }
      @enemies.each { |e| e.draw }
    end
  end

  def button_down(id)
    if id == Gosu::KbSpace
      @gun_sample.play if sounds_enabled?

      x, y = calculate_bullet_start_position

      @bullets.push Bullet.new(x, y, @player.angle, @bullet_image)
    end
  end

  def button_up(id)
    @s_key_held_down = false if id == Gosu::KbS
  end

  private
  def calculate_camera_translation(axis_position, axis_screen_size, axis_level_size)
    return 0 if axis_position < axis_screen_size/2.0
    return -axis_level_size + axis_screen_size if axis_position > axis_level_size - axis_screen_size/2.0
    return axis_screen_size/2.0 - axis_position
  end

  def sounds_enabled?
    return @sounds_enabled
  end

  def calculate_bullet_start_position
    distance_from_player = 15
    gun_offset = 5

    x, y = @player.x - gun_offset, @player.y - distance_from_player

    x, y = rotate(x, -y, @player.x, -@player.y, @player.angle)

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

  def s_key_held_down?
    return @s_key_held_down
  end
end

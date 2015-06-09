require 'gosu'
require_relative 'player'
require_relative 'level'
require_relative 'bullet'
require_relative 'enemy'

class Window < Gosu::Window
  WIDTH = 640
  HEIGHT = 480

  attr_reader :bullets, :player, :enemies
  attr_writer :sounds_enabled

  def initialize
    super WIDTH, HEIGHT, false
    self.caption = 'Sexy Vampire Shooter'

    @sounds_enabled = true

    @bullet_image = Gosu::Image.new(self, 'media/bullet.png', true)
    @bullets = Array.new

    @player = Player.new(Gosu::Image.load_tiles(self, 'media/player.png', 16, 21, true), @bullet_image, Gosu::Image.new(self, 'media/dead_player.png', true))
    @player.warp(Level::WIDTH/2.0, Level::HEIGHT/2.0)

    tile_images = Array.new
    tile_images.push Gosu::Image.new(self, 'media/tile.png', true)
    tile_images.push Gosu::Image.new(self, 'media/tile2.png', true)

    debris_images = Gosu::Image.load_tiles(self, 'media/debris_rocks.png', 58, 60, true)

    @level = Level.new tile_images, debris_images

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
          e.shot_cooldown = 60
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

    bullets_hitting_player = @bullets.select { |b| Gosu::distance(b.x, b.y, @player.x, @player.y) < 8 }
    @player.dying_timer = 300 if !@player.dying? and !bullets_hitting_player.empty?
    @bullets -= bullets_hitting_player
    @player.dying_timer -= 1
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

      @bullets << @player.shoot
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

  def s_key_held_down?
    return @s_key_held_down
  end
end

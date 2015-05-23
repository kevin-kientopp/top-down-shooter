require 'minitest/autorun'
require 'top_down_shooter/window'
require 'gosu'

class TestWindow < Minitest::Test
  def test_shoot_gun_up
    window = Window.new
    window.sounds_enabled = false
    window.button_down Gosu::KbSpace

    assert_equal(1, window.bullets.size)
    assert_equal(window.player.x - 5, window.bullets[0].x)
    assert_equal(window.player.y - 15, window.bullets[0].y)
  end

  def test_shoot_gun_right
    window = Window.new
    window.sounds_enabled = false
    window.player.move_right
    window.button_down Gosu::KbSpace

    assert_equal(1, window.bullets.size)
    assert_equal(window.player.x + 15, window.bullets[0].x)
    assert_equal(window.player.y - 5, window.bullets[0].y)
  end

  def test_shoot_gun_down
    window = Window.new
    window.sounds_enabled = false
    window.player.move_down
    window.button_down Gosu::KbSpace

    assert_equal(1, window.bullets.size)
    assert_equal(window.player.x + 5, window.bullets[0].x)
    assert_equal(window.player.y + 15, window.bullets[0].y)
  end

  def test_shoot_gun_left
    window = Window.new
    window.sounds_enabled = false
    window.player.move_left
    window.button_down Gosu::KbSpace

    assert_equal(1, window.bullets.size)
    assert_equal(window.player.x - 15, window.bullets[0].x)
    assert_equal(window.player.y + 5, window.bullets[0].y)
  end

  def test_update_decrements_enemy_shot_cooldown
    window = Window.new
    window.sounds_enabled = false
    window.enemies.first.shot_cooldown = 5

    window.update

    assert_equal(4, window.enemies.first.shot_cooldown)
  end

  def test_enemy_fires_shot_on_update_when_ready
    window = Window.new
    window.sounds_enabled = false
    window.update

    assert_equal(1, window.enemies.first.bullets.size)
  end
end

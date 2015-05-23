require 'minitest/autorun'
require 'top_down_shooter/enemy.rb'
require 'top_down_shooter/player.rb'

class TestEnemy < Minitest::Test
  def test_is_aware_of_player_within_range
    enemy = Enemy.new(0, 0, 0, nil, nil)
    assert_equal(true, enemy.is_aware_of?(Player.new(nil)))
  end

  def test_is_aware_of_player_within_range
    enemy = Enemy.new(0, 0, 0, nil, nil)
    player = Player.new(nil)
    player.warp(400, 300)
    assert_equal(false, enemy.is_aware_of?(player))
  end

  def test_turn_towards_player
    enemy = Enemy.new(0, 0, 0, nil, nil)
    player = Player.new(nil)
    player.warp(enemy.x + 50, enemy.y)
    enemy.turn_towards player
    assert_equal(2, enemy.angle)
  end
end

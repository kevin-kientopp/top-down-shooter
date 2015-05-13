require 'minitest/autorun'
require 'top_down_shooter/enemy.rb'
require 'top_down_shooter/player.rb'

class TestEnemy < Minitest::Test
  def test_is_aware_of_player_within_range
    enemy = Enemy.new(0, 0, nil)
    assert_equal(true, enemy.is_aware_of?(Player.new(nil)))
  end

  def test_is_aware_of_player_within_range
    enemy = Enemy.new(0, 0, nil)
    player = Player.new(nil)
    player.warp(400, 300)
    assert_equal(false, enemy.is_aware_of?(player))
  end
end

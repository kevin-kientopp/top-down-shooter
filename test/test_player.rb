require 'minitest/autorun'
require 'top_down_shooter/player'

class TestPlayer < Minitest::Test
  def test_move_up
    player = Player.new nil
    player.move_up

    assert_equal(-Player::VELOCITY, player.y)
  end
end

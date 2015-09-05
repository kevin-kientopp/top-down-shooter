require 'minitest/autorun'

class TestDyingPlayer < Minitest::Test
  def test_does_not_move_left
    dying_player = DyingPlayer.new nil
    x, y = dying_player.x, dying_player.y
    dying_player.move_left nil
    assert_equal(x, dying_player.x)
    assert_equal(y, dying_player.y)
  end

  def test_does_not_move_right
    dying_player = DyingPlayer.new nil
    x, y = dying_player.x, dying_player.y
    dying_player.move_right nil
    assert_equal(x, dying_player.x)
    assert_equal(y, dying_player.y)
  end

  def test_does_not_move_up
    dying_player = DyingPlayer.new nil
    x, y = dying_player.x, dying_player.y
    dying_player.move_up nil
    assert_equal(x, dying_player.x)
    assert_equal(y, dying_player.y)
  end

  def test_does_not_move_down
    dying_player = DyingPlayer.new nil
    x, y = dying_player.x, dying_player.y
    dying_player.move_down nil
    assert_equal(x, dying_player.x)
    assert_equal(y, dying_player.y)
  end
end

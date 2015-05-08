require "./lib/bullet.rb"
require "test/unit"

class TestBullet < Test::Unit::TestCase
  def test_move_down
    bullet = Bullet.new(0, 5, 0, nil)
    bullet.move

    assert_equal(7, bullet.y)
  end
end

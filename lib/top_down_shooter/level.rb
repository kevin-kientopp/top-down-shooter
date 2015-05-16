require_relative 'tile'
require_relative 'debris'

class Level
  WIDTH = 20*Tile::WIDTH
  HEIGHT = 20*Tile::HEIGHT

  def initialize(images, debris_images)
    random = Random.new

    @tiles = Array.new(20) { |e| e = Array.new(20) { |i| i = Tile.new(Tile::WIDTH/2.0+i*Tile::WIDTH, Tile::HEIGHT/2.0+e*Tile::HEIGHT, images.sample) } }
    @debris = Array.new(15) { |e| e = Array.new(15) { |i| i = Debris.new debris_images, random.rand(0...Level::WIDTH), random.rand(0...Level::HEIGHT), random.rand(0...2) } }
  end

  def draw(bullets)
    @tiles.flatten.each { |e| e.draw }

    @debris.flatten.each { |e| bullets.each { |b| e.hit_by?(b)}; e.draw }
  end
end

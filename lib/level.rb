require_relative 'tile'

class Level
  WIDTH = 20*Tile::WIDTH
  HEIGHT = 20*Tile::HEIGHT

  def initialize(images)
    @tiles = Array.new(20) { |e| e = Array.new(20) { |i| i = Tile.new(Tile::WIDTH/2.0+i*Tile::WIDTH, Tile::HEIGHT/2.0+e*Tile::HEIGHT, images.sample) } }
  end

  def draw
    @tiles.flatten.each { |e| e.draw }
  end
end

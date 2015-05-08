# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |s|
  s.name     = "top-down-shooter"
  s.version  = '1.0'
  s.summary  = "A top-down-shooter."
  s.authors  = ["Kevin Kientopp", "John McCarthy"]
  s.email    = ["kevinkientopp@gmail.com"]
  s.homepage = "https://github.com/kevin-kientopp/top-down-shooter"
  s.files    = ["lib/bullet.rb", "lib/level.rb", "lib/main.rb", "lib/player.rb", "lib/tile.rb", "lib/window.rb"] 
end

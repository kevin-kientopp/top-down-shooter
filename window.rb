class Window < Gosu::Window
	WIDTH = 640
	HEIGHT = 480

	def initialize
		super WIDTH, HEIGHT, false
		self.caption = 'Sexy Vampire Shooter'

		@player = Player.new(self, Gosu::Image.new(self, 'media/player.png', true))
		@player.warp(320, 240)
	end
	
	def update
		
	end

	def draw
		@player.draw
	end

	def button_down(id)
		
	end
end
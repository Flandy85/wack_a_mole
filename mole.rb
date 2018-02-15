require 'gosu'

# Class WackaMole
class WhackaMole < Gosu::Window
	def initialize
		super(800,600) # Size of game window
		self.caption = "Whack a Mole" # Game title on game window

		# Instance variable that creates an instance of image
		@image = Gosu::Image.new('images/mole.png')

		# x and y instance variables that decides where mole image will appear in game window
		@x = 200 # Distance from the left side of gamewindow (200px)
		@y = 200 # Distance from top side of gamewindow (200px)
	end
end
# Save class in to variable
window = WhackaMole.new
# Show gamewindow
window.show
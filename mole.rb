require 'gosu'

# Class WackaMole fetching Gosu library
class WhackaMole < Gosu::Window
	def initialize
		super(800,600) # Size of game window
		self.caption = "Whack a Mole" # Game title on game window

		# Instance variable that creates an instance of mole image
		@image = Gosu::Image.new('images/mole.png')

		# x and y instance variables that decides where mole image will appear in game window
		@x = 200 # Distance from the left side of gamewindow (200px)
		@y = 200 # Distance from top side of gamewindow (200px)

		# @width and @height instance variables is for finding the center of the mole image
		@width = 100
		@height = 75

		# Instance variabels for movements of mole
		@velocity_x = 5 # speed 5
		@velocity_y = 5

		# Instance variable for making mole blink
		@visible = 0

		# Instance variable that creates instance of hammer image
		@hammer = Gosu::Image.new('images/hammer.png')
	end

	# Draws the mole image in gamewindow
	def draw
		# Only show mole if @visibile is greater than 0
		if @visible > 0
			@image.draw(@x - @width / 2, @y - @height / 2, 1) # image coords and if there are more images than 1, the number 1 decides position in gamewindow
		end
		# Draw hammer and be visible all the time and its movement coords based on mouse movement
		@hammer.draw(mouse_x - 25, mouse_y - 39, 1)
	end

	# Updates all animation and movements in the game
	def update
		@x += @velocity_x
		@y += @velocity_y

		# If mole hits game wall change direction instead of passing throu
		@velocity_x *= -1 if @x + @width / 2 > 800 || @x - @width / 2 < 0 
		@velocity_y *= -1 if @y + @height / 2 > 600 || @y - @height / 2 < 1 

		# Making mole invisible for 10 frames
		@visible -= 1
		# Making mole visible for 50 frames
		@visible = 30 if @visible < -10 && rand < 0.01
	end
end

# Save class in to variable window
window = WhackaMole.new
# Show gamewindow
window.show
require 'gosu'

# module ZOrder
# 	BACKGROUND, UI = *0..3
# end
# Class WackaMole fetching Gosu library
class WhackaMole < Gosu::Window
	def initialize
		super(800,600) # Size of game window
		self.caption = "Whack a Mole" # Game title on game window

		# Instance variable that creates an instance of mole image
		@image = Gosu::Image.new('images/mole.png')
		@soil = Gosu::Image.new('images/soil-background.jpg', :tileable => true)

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

		#Instance variable for handling mouse click for hammer
		@hit = 0

		# Instance variable for keeping score and showing on screen
		@font = Gosu::Font.new(20)
		@score = 0
		

		# When time limit hits 0
		@playing = true

		@start_time = 0
	end

	# Draws the mole image in gamewindow
	def draw
		@soil.draw(0, 0, 0)
		# Only show mole if @visibile is greater than 0
		if @visible > 0
			@image.draw(@x - @width / 2, @y - @height / 2, 1) # image coords and if there are more images than 1, the number 1 decides position in gamewindow
		end
		# Draw hammer and be visible all the time and its movement coords based on mouse movement
		@hammer.draw(mouse_x - 25, mouse_y - 39, 1)

		# Check if mole was hit or missed with button click
		# and change background color based on hit or miss
		if @hit == 0
			c = Gosu::Color::NONE
		elsif @hit == 1
			c = Gosu::Color::GREEN
		elsif @hit == -1
			c = Gosu::Color::RED
		end

		# Make background color square shaped to fit gamewindow
		draw_quad(0, 0, c, 800, 0, c, 800, 600, c, 0, 600, c)
		@hit = 0

		# Show score on gamewindow
		@font.draw("Score: #{ @score.to_s }", 630, 50, 2)
		@font.draw(@time_left.to_s, 30, 50, 2)

		# Unless loop, activates when timelimit has reached zero.
		unless @playing
			if @score <= 0
				@font.draw("Game over!! Your score: #{ @score }! Are you serious!?", 200, 300, 3)
			end
			if @score > 0 && @score <= 30
				@font.draw("Game over!! Your score: #{ @score }!", 300, 300, 3)
			end
			if @score >= 31 && @score <= 60
				@font.draw("Game over!! Your score: #{ @score }! Well done!", 250, 300, 3)
			end
			if @score >= 61 && @score < 89
				@font.draw("Game over!! Your score: #{ @score }! SUPERPLAYER!", 250, 300, 3)
			end
			if @score >= 90
				@font.draw("Game over!! Your score: #{ @score }! GODLIKE!", 250, 300, 3)
			end

			@visible = 20
			@time_left = 0
			@font.draw("Press Spacebar to play again!", 300, 350, 3)
			@font.draw("Press ESCAPE to quit!", 300, 370, 3)
		end	
			
	end

	# Updates all animation and movements in the game
	def update
		# if playing the game
		if @playing
			@x += @velocity_x
			@y += @velocity_y

			# If mole hits game wall change direction instead of passing throu
			@velocity_x *= -1 if @x + @width / 2 > 800 || @x - @width / 2 < 0 
			@velocity_y *= -1 if @y + @height / 2 > 600 || @y - @height / 2 < 1 

			# Making mole invisible for 10 frames
			@visible -= 1
			# Making mole visible for 50 frames
			@visible = 50 if @visible < -10 && rand < 0.01

			# Time limit for game session, 30 sec
			@time_left = (30 - ((Gosu.milliseconds - @start_time) / 1000))

			# If timelimit has reached 0
			@playing = false if @time_left < 0
		end
	end

	# Method for handling mouse click, button_down is a gosu method that handles whatever
	# if its a mouse, gamepad, keyboard or mousepad
	def button_down(id)
		if @playing
			# Using left mouse button, check if left mouse button was pressed
			if(id == Gosu::MsLeft)
				# Check if left mouse button was clicked with hammer distance 60 frames from mole image and if 
				# mole image was visible
				if Gosu.distance(mouse_x, mouse_y, @x, @y) < 60 && @visible >= 0
					@hit = 1
					@score += 10
				else
					@hit = -1
					@score -= 3
				end
			end
		elsif
			# Press spacebar to restart
			if(id == Gosu::KbSpace)
				@playing = true
				@visible = -10
				@start_time = Gosu.milliseconds
				@score = 0
			end
		else
			# Press escape to quit
			if (id == Gosu::KB_ESCAPE)
	      		close
	    	end
		end
	end
end

# Save class in to variable window
window = WhackaMole.new
# Show gamewindow
window.show
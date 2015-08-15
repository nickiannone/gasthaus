require 'gosu'
require './resources'

class GameWindow < Gosu::Window
  
	def initialize(width=800, height=600, fullscreen=false)
		super
		self.caption = 'Spookhouse'
		@thing = Resources.load_image('images/thing.png')
		@background = Resources.load_image('images/bg.png')
		@time = Time.now.strftime("%d/%m/%Y %H:%M")
		@x = rand(width - @thing.width)
		@y = rand(height - @thing.height)
		@dx = 0
		@dy = 0
		@dragging = false
		@firstframe = true
		@timediff = true
	end
	
	def mouse_over(x1, y1, x2, y2)
	  x = self.mouse_x
	  y = self.mouse_y
    x >= x1 && x <= x2 && y >= y1 && y <= y2
  end
	
	# Gosu callbacks - pipe into the level object.
	
	def draw
	  # draw some images
	  @background.draw(0, 0, -1)
	  @thing.draw(@x, @y, 1)
	  timertext = Gosu::Image.from_text(@time, 12)
	  timertext.draw(0, 0, 0)
	  if @timediff then
	    @timediff = false
	  end
	  if @firstframe then
	    @firstframe = false
	  end
	end
	
	def update
	  # render a timer
	  new_time = Time.now.strftime("%d/%m/%Y %H:%M:%S")
	  if new_time != @time then
	    @time = new_time
	    @timediff = true
	  end
	  if @dragging then
	    @x = self.mouse_x - @dx
	    @y = self.mouse_y - @dy
	  end
	end
	
	def button_down(id)
	  # Start dragging.
	  if id == Gosu::MsLeft && !@dragging && mouse_over(@x, @y, @x + @thing.width, @y + @thing.height) then
	    @dx = self.mouse_x - @x
	    @dy = self.mouse_y - @y
	    @dragging = true
	  end
	end
	
	def button_up(id)
	  # Let go of the drag and snap inside the window.
	  if id == Gosu::MsLeft && @dragging then
	    @dragging = false
	    @x = [0, @x, 800].sort[1]
	    @y = [0, @y, 600].sort[1]
	  end
	end
	
	def needs_cursor?
	  true
	end
	
	def needs_redraw?
	  @firstframe || @dragging || @timediff
	end
end

window = GameWindow.new
window.show

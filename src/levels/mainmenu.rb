require 'gosu'
require './level'

module Levels
	class MainMenu < Level
		# TODO Implement!
		def initialize
		  
		end
		
		# Game callbacks
    def set_up(gamewindow)
      
    end
    
    def tear_down(gamewindow)
    end
    
    # Gosu callbacks
    def draw(gamewindow)
      # TODO draw the main menu buttons
    end
    
    def update(gamewindow)
      # TODO pump animation into main menu
    end
    
    def button_down(gamewindow, id)
      # TODO pump mouse/keyboard input into main menu
    end
    
    def button_up(gamewindow, id)
      # TODO pump mouse/keyboard input into main menu
    end
    
    def needs_cursor?
      true
    end
    
    def needs_redraw?
      # TODO return the main menu's redraw
    end
	end
end

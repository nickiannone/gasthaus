require 'gosu'
require './level'
require '../resources'
require '../gamewindow'

class TestLevel < Level
  def initialize
    @background = Resources.load_image('images/bg.png')
    @guy = Customer.new('images/characters/testcust.png')
  end
  
  # Game callbacks
  def set_up(gamewindow)
    # TODO Place guy into window at some point!
  end
  
  def tear_down(gamewindow)
  end
  
  # Gosu callbacks
  def draw(gamewindow)
    @background.draw(gamewindow)
    @guy.draw(gamewindow)
  end
  
  def update(gamewindow)
    @guy.update
  end
  
  def button_down(gamewindow, id)
    
  end
  
  def button_up(gamewindow, id)
  end
  
  def needs_cursor?
  end
  
  def needs_redraw?
  end
end

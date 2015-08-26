require 'gosu'

class GameObject
  attr_accessor :x, :y, :visible, :frame
  
  def initialize
    @x = @y = 0
    @visible = false
    @frame = nil
  end
  
  def draw
    if @frame != nil && @visible then
      @frame.draw(@x - (@frame.width / 2), @y - @frame.height, @y)
    end
  end
  
  def width
    @frame.width
  end
  
  def height 
    @frame.height
  end
  
  def update_anim
  end
  
  def update_ai
  end
  
  # Mouse events?
end

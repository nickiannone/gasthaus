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
end

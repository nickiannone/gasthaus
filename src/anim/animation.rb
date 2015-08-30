require 'gosu'
require './frame'

class Animation
  def initialize()
    @name = nil
    @frames = []
  end
  
  def frame_lerp(time)
    time %= @frames[@frames.length-1].time
    if time <= 0.0 then
      return @frames[0]
    end
    nextFrame = 0
    for i in 0..@frames.length-1 do
      if time == @frames[i].time then
        return @frames[i]
      end
      if time > @frames[i].time then
        nextFrame = i+1
		break
      end
    end
    Frame.interpolate(@frames[0..nextFrame], time)
  end
  
  def anim_time
    @frames[@frames.length-1].time
  end
end

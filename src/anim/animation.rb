require 'gosu'

class Animation
  def initialize()
    @name = nil
    @frames = []
  end
  
  def frame_lerp(time)
    time %= @frames[@frames.length-1].time
    if time == 0.0 then
      return @frames[0]
    end
    for i in 0..@frames.length-1 do
      if time == @frames[i].time then
        return @frames[i]
      end
      if time > @frames[i].time then
        # TODO Generate a new frame between the two given frames.
        return Frame.new(@frames[i], @frames[i+1], time - @frames[i].time)
      end
    end
  end
end

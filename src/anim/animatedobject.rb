class AnimatedObject
  attr_accessor :anim_set, :mesh, :curr_anim_name, :curr_anim_time, :pos
  
  def initialize(anim_set, mesh)
    @anim_set = anim_set # used indirectly
    @mesh = mesh.clone # TODO Implement mesh.clone?
  end
  
  # TODO Hook this into the update system!
  def update(delta_time)
    # Add the delta time to the animation, and roll back if past the end of the animation
    max_anim_time = @anim_set[@curr_anim_name].anim_time
    @curr_anim_time += delta_time
    if @curr_anim_time > max_anim_time then
      # TODO Callback for animation loop?
      @curr_anim_time %= max_anim_time
    end
  end
  
  # Sets the current animation and resets the animation time.
  def set_animation(animation)
    @curr_anim_name = animation
    @curr_anim_time = 0.0
  end
end
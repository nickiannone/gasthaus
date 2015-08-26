require 'gosu'

class AnimationSystem
  
  def initialize()
  end
  
  def draw(animated_objects)
    @draw_buffer = []
    animated_objects.each do |obj|
      current_anim = obj.anim_set.animations[obj.curr_anim_name]
      current_subframe = current_anim.frame_lerp(obj.curr_anim_time)
      current_subframe.apply_to_mesh(obj.mesh)
      sorted_edges = depth_sort(obj.mesh.edges())
      anim_blocks = create_anim_blocks(sorted_edges)
      @draw_buffer << anim_blocks
    end
    @draw_buffer.flatten!
    @draw_buffer.each do |block|
      p1, p2, p3, p4 = block.calculate_scene_pos
      c1, c2, c3, c4 = calculate_lighting(block, p1, p2, p3, p4)
      block.skin.draw_as_quad(
        p1.x, p1.y, c1,
        p2.x, p2.y, c2,
        p3.x, p3.y, c3,
        p4.x, p4.y, c4,
        block.z, block.mode
      )
    end
  end
end

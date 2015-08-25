# Animation system

The animation system used in Spookhouse is a simple 2d mesh/keyframe-based pipeline animation system which consumes a mesh, a set of animations, and a selected animation and time, and produces a set of basic commands to draw each individual component of each animated object.

## Primitives Overview
The Spookhouse animation system consists of several primitives and an animation subsystem which serves to transform them into raw commands to draw images in the correct order. The four high-level primitives are: Meshes, AnimSets, AnimatedObjects, and AnimBlocks.

### Mesh
A Mesh is just a directed acyclic graph (DAG) of vertices, containing only an ID, and edges, containing an ID and a default angle and length. They contain just enough information to be rendered as a wireframe. The root vertex serves as the point where the mesh is anchored to the ground, and is used as the origin of the relative coordinate system. All positioning information is represented in polar coordinates to allow for smoother character animations (though it might make things difficult for, say, a rotating-wall tunnel). Once in memory, though, edges will also be used to store all basic information needed to make an AnimBlock, such as skinning and lighting info.

### AnimSet
An AnimSet contains a number of named Animations, each of which contains a series of Frames (keyframes) and other information. It provides the time-based animation transformations to an associated Mesh. Each Frame consists of the keyframe time and a number of EdgeTransforms (possible name change is in order). Edge Transforms point to an edge, and tell it how to be rendered at that point in time, covering edge length, relative angle, and skinning information (which is where the actual visible aspect of the animation is brought in).

### AnimatedObject
An AnimatedObject serves as the object being animated. Each one contains the objects' position in the world, an instance of the mesh, and a reference to the current animation set. It also keeps track of the currently-playing animation from the set, as well as the time offset into the current animation. All of this information is grabbed by the animation system and used to render each frame.

### AnimBlock
An AnimBlock is the atomic unit of rendering in the animation system. When the animation system consumes an AnimatedObject, it spits out a bunch of AnimBlocks containing the raw rendering information for the screen. Since our renderer just uses composition to build up each rendered frame of the scene, the goal is to make simple little units that can be strung together and dumped onto the screen in order. As such, AnimBlocks contain a reference to the primitive they're supposed to render (usually an Image), as well as information such as scene position, depth, rotation, and flip. Eventually, these may also contain lighting and shading information.

## Animation System Overview

The animation system itself is responsible for consuming the base primitives and spitting out the series of AnimBlocks to be rendered in the Gosu draw method. The general flow of the system is as follows:

    # potentially parallelizable portion
    animated_objects.each |obj| do
      current_anim = obj.anim_set.animations[obj.curr_anim_name]  # needs to handle animation cycling/chaining events
      current_subframe = frame_lerp(current_anim, obj.curr_anim_time)
      obj.mesh.apply_anim_frame(current_subframe) # applies angle, length, depth, skin, and lighting info to in-memory edges
      sorted_edges = depth_sort(obj.mesh.edges())
      obj.anim_blocks = create_anim_blocks(sorted_edges)
    end
    
    # gather step
    animated_objects.each |obj| do
      @render_buffer.add_blocks(obj.anim_blocks)
    end

This pipeline is inherently parallelizable, as well; by using a divide-and-conquer method, we can split up the generation of AnimBlocks into separate threads, and then gather all produced blocks into a z-buffer. If we pre-sort the list of animated objects by depth as well, we can end up with a very fast gather and minimal overhead from insertion into the final z-buffer.

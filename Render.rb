require 'ruby2d'

#Activity
@circle = Circle.new(
    x: 0, y: 0,
    radius: 25,
    sectors: 32,
    color: 'red',
    z: 10
  )
@is_pressed = false

on :mouse_down do |event|
  # x and y coordinates of the mouse button event
  puts event.x, event.y

  # Read the button event
  case event.button
  when :left
    # Left mouse button pressed down
    @is_pressed = !@is_pressed
  when :middle
    # Middle mouse button pressed down
  when :right
    # Right mouse button pressed down
  end
end

on :mouse_move do |event|
  if @is_pressed == true
    # Change in the x and y coordinates
    puts event.delta_x
    puts event.delta_y

    # Position of the mouse
    puts event.x, event.y

    @circle.x = event.x
    @circle.y = event.y
  end
end

show

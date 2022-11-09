require 'ruby2d'
require_relative 'Graph'
# require_relative 'Render'

graph = Graph.new

graph.add_Activity(3)
graph.add_Activity(2)
graph.add_Activity(1)

graph.activities[0].add_connection(graph.activities[1])
graph.activities[0].add_connection(graph.activities[2])
graph.activities[2].add_connection(graph.activities[0])

# puts graph.activities.inspect
# graph.activities.each { |n| puts n.inspect}
puts 'test'

graph.activities[0].update(30,40)
graph.activities[1].update(20,60)
graph.activities[2].update(70,10)

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
      graph.activities.each do |Activity|
        Activity.position[0] = event.x
        Activity.position[1] = event.y
      end
      # Activity.update(event.x,event.y)
    end
end


graph.draw
show

#hash life <- algorytm do kodowania struktur drzewiastych

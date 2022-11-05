require 'ruby2d'
require_relative 'Graph'
# require_relative 'Render'

graph = Graph.new

graph.add_node(3)
graph.add_node(2)
graph.add_node(1)

graph.nodes[0].add_connection(graph.nodes[1])
graph.nodes[0].add_connection(graph.nodes[2])
graph.nodes[2].add_connection(graph.nodes[0])

# puts graph.nodes.inspect
# graph.nodes.each { |n| puts n.inspect}
puts 'test'

graph.nodes[0].update(30,40)
graph.nodes[1].update(20,60)
graph.nodes[2].update(70,10)

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
      graph.nodes.each do |node|
        node.position[0] = event.x
        node.position[1] = event.y
      end
      # node.update(event.x,event.y)
    end
end


graph.draw
show

#hash life <- algorytm do kodowania struktur drzewiastych

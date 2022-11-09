require_relative 'Activity'
require_relative 'Graph'
# require_relative 'Render'

require 'ruby2d'

graph = Graph.new()
graph.read_file("tasks.txt")
graph.is_cyclic_info()
graph.write_graph()
puts "------------"
graph.critical_path()
puts "------------"
graph.activities.sort_by(&:id)
puts "------------"
graph.write_graph()

# show

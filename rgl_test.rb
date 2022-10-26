require 'rgl/adjacency'
require 'rgl/dot'
#https://github.com/monora/rgl

graph = RGL::DirectedAdjacencyGraph.new

graph.add_edge 1,2
graph.add_edge 3,4
graph.add_edge 1,4
graph.add_edge 4,3

graph.print_dotted_on
class Node
  attr_accessor :id, :value, :neighbors

  def initialize(id, value)
    @id = id
    @value = value
    @neighbors = []
  end

  def add_edge(neighbor)
    @neighbors << neighbor
  end
end

class Graph
  attr_accessor :nodes

  def initialize
    @nodes = []
  end

  def add_node(id, value)
    @nodes << Node.new(id, value)
  end

  def find_node_by_id(id)
    @nodes.each do |node|
      return node if node.id == id
    end
    nil
  end

  def connect(id1, id2)
    find_node_by_id(id1).add_edge(find_node_by_id(id2))
  end

  def is_cyclic_ut(i, visited, rec_stack)
    if rec_stack[i]
      return true
    end

    if visited[i]
      return false
    end

    visited[i] = true
    rec_stack[i] = true

    children = nodes[i].neighbors
    children.each do |child|
      if is_cyclic_ut(nodes.index(child), visited, rec_stack)
        return true
      end
    end

    rec_stack[i] = false

    return false
  end

  def is_cyclic()
    visited = Array.new(nodes.length(), false)
    rec_stack = Array.new(nodes.length(), false)

    (0..@nodes.length()-1).each do |i|
      if is_cyclic_ut(i, visited, rec_stack)
        return true
      end
    end

    return false
  end

end


graph = Graph.new()

graph.add_node(1, 2)
graph.add_node(2, 3)
graph.add_node(3, 2)
graph.add_node(4, 2)

graph.connect(1,2)
graph.connect(1,3)
graph.connect(2,3)
graph.connect(3,4)
graph.connect(4,2)

graph.nodes.each do |node|
  id = node.id
  value = node.value
  list = []
  node.neighbors.each do |n|
    list << n.id
  end
  puts "#{id} (t:#{value}) -> #{list}"
end

if graph.is_cyclic()
  puts "cyclic"
else
  puts "not cyclic"
end

graph2 = Graph.new()

graph2.add_node(1, 2)
graph2.add_node(2, 3)
graph2.add_node(3, 2)
graph2.add_node(4, 2)

graph2.connect(1,2)
graph2.connect(1,3)
# graph2.connect(2,3)
graph2.connect(3,4)
graph2.connect(4,2)

if graph2.is_cyclic()
  puts "cyclic"
else
  puts "not cyclic"
end

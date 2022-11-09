class Activity
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
  attr_accessor :activities

  def initialize
    @activities = []
  end

  def add_Activity(id, value)
    @activities << Activity.new(id, value)
  end

  def find_Activity_by_id(id)
    @activities.each do |Activity|
      return Activity if Activity.id == id
    end
    nil
  end

  def connect(id1, id2)
    find_Activity_by_id(id1).add_edge(find_Activity_by_id(id2))
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

    children = activities[i].neighbors
    children.each do |child|
      if is_cyclic_ut(activities.index(child), visited, rec_stack)
        return true
      end
    end

    rec_stack[i] = false

    return false
  end

  def is_cyclic()
    visited = Array.new(activities.length(), false)
    rec_stack = Array.new(activities.length(), false)

    (0..@activities.length()-1).each do |i|
      if is_cyclic_ut(i, visited, rec_stack)
        return true
      end
    end

    return false
  end

end


graph = Graph.new()

graph.add_Activity(1, 2)
graph.add_Activity(2, 3)
graph.add_Activity(3, 2)
graph.add_Activity(4, 2)

graph.connect(1,2)
graph.connect(1,3)
graph.connect(2,3)
graph.connect(3,4)
graph.connect(4,2)

graph.activities.each do |Activity|
  id = Activity.id
  value = Activity.value
  list = []
  Activity.neighbors.each do |n|
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

graph2.add_Activity(1, 2)
graph2.add_Activity(2, 3)
graph2.add_Activity(3, 2)
graph2.add_Activity(4, 2)

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

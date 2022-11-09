require 'ruby2d'

class Activity
  attr_accessor :id, :value, :neighbors, :position, :color

  def initialize(id, value)
    @id = id
    @value = value
    @neighbors = []
    @position = [rand(100..300),rand(100..300)]
    @color = 'white'
  end

  def add_edge(neighbor)
    @neighbors << neighbor
  end

  def update(x,y)
        @position = [x,y]
  end

  def change_color(color)
    @color = color
  end

end

class Arc
  attr_accessor :Activity1, :Activity2
end

class Graph
  attr_accessor :activities

  def initialize()
    @activities = []
  end

  def add_Activity(id, value)
    puts activities
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

    activities[i].change_color('red')
    visited[i] = true
    rec_stack[i] = true

    children = activities[i].neighbors
    children.each do |child|
      if is_cyclic_ut(activities.index(child), visited, rec_stack)
        return true
      end
    end

    activities[i].change_color('white')
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

  def write_graph()
    @activities.each do |Activity|
      id = Activity.id
      value = Activity.value
      list = []
      Activity.neighbors.each do |n|
        list << n.id
      end
      puts "#{id} (t:#{value}) -> #{list}"
    end
  end

  def draw(color)
        @activities.each do |Activity|
            Circle.new(
                x:Activity.position[0],
                y:Activity.position[1],
                radius:5,
                sectors:32,
                color:color,
                z:10
            )

            Text.new(
              "Z#{Activity.id}, #{Activity.value}",
              x:Activity.position[0],
              y:Activity.position[1],
              font: 'Vera.ttf',
              style: 'bold',
              size: 20,
              color: 'black',
              rotate: 0,
              z: 10
            )

            Activity.neighbors.each do |neighbor|
                Line.new(
                  x1:Activity.position[0], y1:Activity.position[1],
                  x2:neighbor.position[0], y2:neighbor.position[1],
                  width:3,
                  color:Activity.color,
                  z:10
                )
                Triangle.new(
                  x1: neighbor.position[0]-15,  y1: neighbor.position[1],
                  x2: neighbor.position[0],  y2: neighbor.position[1]-15,
                  x3: neighbor.position[0],  y3: neighbor.position[1],
                  color: Activity.color,
                  z: 10
                )
            end
        end
    end

end

def read_file(name)
  graph = Graph.new()
  :neighbors

  File.foreach(name) {
    |line|
      splited_line = line.split.map(&:to_i)
      id = splited_line[0]
      value = splited_line[1]
      @neighbors = splited_line.drop(2)

      puts "line: #{line}"
      puts "id: #{id}"
      puts "time: #{value}"
      puts "neighbors: #{@neighbors}"

      #create Activity
      graph.add_Activity(id, value)
  }
  return graph
end

# graph = Graph.new()

# loop do
#   max = 20

#   (1..max).each do |i|
#     graph.add_Activity(i, rand(1..5))
#   end

#   (1..rand(5..graph.activities.length)).each do |i|
#     graph.connect(rand(i..graph.activities.length),rand(1..graph.activities.length))
#   end

#   if graph.is_cyclic()
#     break
#   end

#   graph.activities = []
# end





# if graph.is_cyclic()
#   puts "cyclic"
# else
#   puts "not cyclic"
# end

# graph2.connect(1,2)
# graph2.connect(1,3)
# # graph2.connect(2,3)
# graph2.connect(3,4)
# graph2.connect(4,2)
# graph2.connect(5,3)
# graph2.connect(6,4)
# graph2.connect(7,2)

#main

set resizable: true

tick = 0

set background: 'blue'

# graph2.is_cyclic()
# graph2.write_graph()

# update do
#   if tick % 120 == 0
#     clear

#     graph2.activities.each do |Activity|
#       r1 = rand(-10..10)
#       r2 = rand(-10..10)
#       if Activity.position[0] + r1>100 and Activity.position[0] + r1<500
#         Activity.position[0] += r1
#       end
#       if Activity.position[1] + r2>100 and Activity.position[1] + r2<500
#         Activity.position[1] += r2
#       end
#     end
#     graph2.draw('red')

#   end

#   tick += 1
# end

# graph2 = Graph.new()
# puts graph2.activities
# graph2.add_Activity(1,1)
# graph2.add_Activity(2,1)
# graph2.add_Activity(3,1)
# graph2.connect(1,2)
# graph2.connect(3,2)
# graph2.draw("black")

graph = read_file("tasks.txt")
graph.draw("red")

show

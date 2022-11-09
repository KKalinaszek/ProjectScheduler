require 'ruby2d'

set resizable: true
set background: 'blue'

class Activity
  attr_accessor :id, :value, :neighbors, :position, :color

  def initialize(id, value)
    @id = id
    @value = value
    @neighbors = []
    @position = [rand(10..350),rand(10..600)]
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

class Graph
  attr_accessor :activities

  def initialize()
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

  def walk_list_ahead

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
                dx = Activity.position[0] - neighbor.position[0]
                dy = Activity.position[1] - neighbor.position[1]
                norm = Math.sqrt(dx*dx+dy*dy)
                udx = dx/norm
                udy = dy/norm
                ax = udx * Math.sqrt(3)/2 - udy * 1/2
                ay = udx * 1/2 + udy * Math.sqrt(3)/2
                bx = udx * Math.sqrt(3)/2 + udy * 1/2
                by =  - udx * 1/2 + udy * Math.sqrt(3)/2
                Triangle.new(
                  x1: neighbor.position[0] + 20 * ax,  y1: neighbor.position[1] + 20 * ay,
                  x2: neighbor.position[0] + 20 * bx,  y2: neighbor.position[1] + 20 * by,
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
  activities = []
  i = 0

  File.foreach(name) {
    |line|
      activities[i] = line.split.map(&:to_i)
      i+=1
  }
  #create Activity
  activities.each do |Activity|
    graph.add_Activity(Activity[0], Activity[1])
  end

  #create children
  activities.each do |Activity|
    Activity[2..Activity.length()-1].each do |n|
      graph.connect(Activity[0], n)
    end
  end

  return graph
end



#main

graph = read_file("tasks.txt")
puts graph.is_cyclic()
graph.draw("red")

show

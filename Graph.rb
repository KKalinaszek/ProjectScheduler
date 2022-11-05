require 'ruby2d'

class Node
    attr_accessor :weight, :neighbors, :position

    def initialize(weight)
        @weight = weight
        @neighbors = []
        @position = [0,0]
    end

    def add_connection(neighbor)
    @neighbors << neighbor
    end

    def update(x,y)
        @position = [x,y]
    end
end

class Graph
    attr_accessor :nodes
    @is_pressed = false

    def initialize
        @nodes = []
    end

    def add_node(weight)
    @nodes << Node.new(weight)
    end

    def draw
        @nodes.each do |node|
            Circle.new(
                x:node.position[0],
                y:node.position[1],
                radius:25,
                sectors:32,
                color:'red',
                z:10
            )

            node.neighbors.each do |neighbor|
                Line.new(
                    x1:node.position[0], y1:node.position[1],
                    x2:neighbor.position[0], y2:neighbor.position[1],
                    width:10,
                    color:'white',
                    z:10
                )
            end
        end
    end
end

require 'ruby2d'

class Activity
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
    attr_accessor :activities
    @is_pressed = false

    def initialize
        @activities = []
    end

    def add_Activity(weight)
    @activities << Activity.new(weight)
    end

    def draw
        @activities.each do |Activity|
            Circle.new(
                x:Activity.position[0],
                y:Activity.position[1],
                radius:25,
                sectors:32,
                color:'red',
                z:10
            )

            Activity.neighbors.each do |neighbor|
                Line.new(
                    x1:Activity.position[0], y1:Activity.position[1],
                    x2:neighbor.position[0], y2:neighbor.position[1],
                    width:10,
                    color:'white',
                    z:10
                )
            end
        end
    end
end

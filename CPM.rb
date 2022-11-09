class Activity
    attr_accessor :value, :neighbors, :x, :y

    def initialize(value)
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

    def add_Activity(value)
        @activities << Activity.new(value)
    end

    def is_cyclic_ut(i,visited,rec_stack)
        if rec_stack[i]
            true
        end

        if visited[i]
            false
        end


    end

    def is_cyclic()
    end

end


graph = Graph.new()

graph.add_Activity(2)
graph.add_Activity(3)
graph.add_Activity(2)

graph.activities[0].add_edge(graph.activities[1])


puts graph.activities.inspect

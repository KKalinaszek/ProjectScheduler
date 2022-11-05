class Node
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
    attr_accessor :nodes

    def initialize
        @nodes = []
    end

    def add_node(value)
        @nodes << Node.new(value)
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

graph.add_node(2)
graph.add_node(3)
graph.add_node(2)

graph.nodes[0].add_edge(graph.nodes[1])


puts graph.nodes.inspect

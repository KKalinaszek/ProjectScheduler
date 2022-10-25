class Node
    attr_accessor :x, :y
    
    def initialize(x,y)
        @x = x
        @y = y
    end
end

node = Node.new(1, 1)
puts "#{node.x} #{node.y}"
node.x = 3
puts "#{node.x} #{node.y}"

#hash life <- algorytm do kodowania struktur drzewiastych
require 'ruby2d'

set tittle: 'Project Scheduler',
    width: 640,
    heigh: 480,
    resizable: true,
    background: 'blue'

class Activity
  attr_writer :position
  def initialize
    @position = [300,300]
  end

  def draw
    Circle.new(
      x:Activity.position[0],
      y:Activity.position[1],
      radius:25,
      sectors:32,
      color:'red',
      z:10
    )
  end
end

@mouse_pressed = false

on :mouse_down do
  @mouse_pressed = !@mouse_pressed
  puts @mouse_pressed
end

on :mouse_move do |event|
  if @mouse_pressed
    puts event.x
    puts event.y
  end
end



show

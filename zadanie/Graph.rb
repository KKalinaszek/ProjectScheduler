class Graph
  attr_accessor :activities

  def initialize()
    @activities = []
  end

  def read_file(name)
    activities_list = []
    File.foreach(name) {
      |line|
        activities_list.append(line.split.map(&:to_i))
    }

    #create Activity
    activities_list.each do |activity|
      @activities.append(Activity.new(activity[0], activity[1]))
    end

    # #create children
    activities_list.each do |activity|
      activity[2..activity.length()-1].each do |n|
        connect(activity[0], n)
      end
    end

  end

  def add_Activity(id, value)
    @activities << Activity.new(id, value)
  end

  def id_find(id)
    @activities.each do |activity|
      return activity if activity.id == id
    end
    nil
  end

  def connect(id1, id2)
    n1, n2 = id_find(id1), id_find(id2)
    n1.successors << n2
    n2.predecessors << n1
  end

  def write_graph()
    @activities.each do |activity|
      activity.write()
    end
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

    children = activities[i].successors
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

  def is_cyclic_info()
    if is_cyclic()
      puts "Graph is cyclic!!!"
    else
      puts "Graph is not cyclic"
    end
  end

  def walk_list_ahead()
    @activities[0].earliestEND =  @activities[0].earliestST + @activities[0].duration

    (1..@activities.length()-1).each do |i|
      @activities[i].predecessors.each do |activity|
        if @activities[i].earliestST < activity.earliestEND
          @activities[i].earliestST = activity.earliestEND
        end
      end
      @activities[i].earliestEND = @activities[i].earliestST + @activities[i].duration
    end
  end

  def walk_list_back()
    puts "#{@activities[@activities.length()-1].id} = #{@activities[@activities.length()-1].id}"
    @activities[@activities.length()-1].latestEND = @activities[@activities.length()-1].earliestEND
    @activities[@activities.length()-1].latestST = @activities[@activities.length()-1].latestEND - @activities[@activities.length()-1].duration

    puts @activities[@activities.length()-1].write()

    i = @activities.length()-2
    puts @activities[i].write()

    while i >= 0
      @activities[i].successors.each do |activity|
        puts "activity:"
        activity.write()
        if @activities[i].latestEND == 0
          @activities[i].latestEND = activity.latestST
        else
          if @activities[i].latestEND > activity.latestST
            @activities[i].latestEND = activity.latestST
          end
        end
      end

      @activities[i].latestST = @activities[i].latestEND - @activities[i].duration
      puts "i = #{i}"
      i = i - 1
    end

    @activities.sort_by(&:id)

  end

  def critical_path()

    walk_list_ahead()

    @activities.sort_by(&:id)

    walk_list_back()

    puts "Critical Path:"

    @activities.each do |activity|
      if (activity.earliestST == activity.latestST) and (activity.earliestEND == activity.latestEND)
        activity.critical = true
        activity.write()
      else
        activity.critical = false
      end
    end
  end

end

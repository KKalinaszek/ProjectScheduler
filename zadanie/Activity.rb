class Activity
  attr_accessor(
    :id,
    :name,
    :description,
    :duration,
    :earliestST,
    :latestST,
    :earliestEND,
    :latestEND,
    :predecessors,
    :successors,
    :critical,
  )

  def initialize(id, name, duration)
    @id = id
    @duration = duration
    @earliestST = 0
    @latestST = 0
    @earliestEND = 0
    @latestEND = 0
    @predecessors = []
    @successors = []
    @critical = false
  end

  def write()
    pred = []
    succ = []
    @predecessors.each do |p|
      pred.append(p.id)
    end
    @successors.each do |s|
      succ.append(s.id)
    end
    puts "ID:#{@id} name= #{@name} p=#{@duration} pred=#{pred} succ=#{succ} Es=#{@earliestST} Ef=#{@earliestEND} Ls=#{latestST} Lf=#{latestEND} crit.path?=#{@critical}"
  end

end

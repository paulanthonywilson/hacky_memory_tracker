

class MemoryRecord

  attr_reader :memory, :peak, :trough

  def initialize(memory = 0)
    @memory = @peak = @trough = @previous_memory = memory
  end

  def memory=(memory)
    @peak = @memory if memory < @memory && @memory > @previous_memory
    @trough = @memory if memory > @memory && @memory < @previous_memory
    @previous_memory = @memory if memory != @memory
    @memory = memory
  end

  def to_json
    {:memory=>@memory, :trough=>@trough, :peak=>@peak}.to_json
  end

end

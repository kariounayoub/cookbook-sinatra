class Recipe
  attr_reader :name
  attr_reader :description
  attr_reader :prep_time
  attr_reader :difficulty
  attr_accessor :done

  def initialize(name, description, prep_time, difficulty)
    @name = name
    @description = description
    @prep_time = prep_time
    @done = false
    @difficulty = difficulty
  end
end

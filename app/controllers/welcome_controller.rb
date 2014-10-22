class WelcomeController < ApplicationController
  def index
  end

  def question1
  end

  def question2
    @num1 = 100000
    @num2 = 19
    @array = []
    @array_size = 100000 / 19
    @array_size.times do |counter|
      @array << counter * @num2
    end
    @squares_one_count = number_of_squares_ending_in_one @array
    @reflection_count = number_of_reflections @array
    @third_in_s = number_can_be_made_to_another_number @array
  end

  def question3
    grid_after_15 = Grid.new center: 1, seconds: 15
    @center_after_fifteen = grid_after_15.position_probability(2, 2)
    grid_after_hour = Grid.new center: 1, seconds: 3600
    @outer_after_hour = grid_after_hour.outer_probabilities
  end

  private
  # Number of squares that end in one is the same as those that finish in 1 or 9
  def number_of_squares_ending_in_one array
    array.select { |num|
      (num % 10 == 1) || (num % 10 == 9)
    }.count
  end

  #TODO should be a simplier mathematical pattern to this one rather than brute force.
  def number_of_reflections array
    array.select{ |num|
      array.include? num.to_s.reverse.to_i
    }.count
  end

  #TODO should be a simpler mathematical pattern here rather than brute force, see if this is all items under 5263 since that * 19  99997
  def number_can_be_made_to_another_number array
    array.select{ |num|
      array.include? num * 19
    }.count
  end
end
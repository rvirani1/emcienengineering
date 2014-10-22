class Grid
  def initialize opts = {center: 0, seconds: 0}
    @layout = generate_layout
    @layout[2][2] = opts[:center]
    opts[:seconds].times { iterate }
  end

  def iterate
    @new_layout = generate_layout
    @layout.each_with_index do |y_array, y|
      y_array.each_with_index do |value, x|
        generate_probability x, y, value
      end
    end
    @layout = @new_layout
    raise "Total not 1" unless total.round == 1
  end

  def generate_probability x, y, value
    borders = 0
    borders += 1 if [0,4].include? x
    borders += 1 if [0,4].include? y

    # generate outer probability
    if x - 1 >= 0
      @new_layout[y][x] += @layout[y][x-1] * 0.2
    end

    if x + 1 <= 4
      @new_layout[y][x] += @layout[y][x+1] * 0.2
    end

    if y - 1 >= 0
      @new_layout[y][x] += @layout[y-1][x] * 0.2
    end

    if y + 1 <= 4
      @new_layout[y][x] += @layout[y+1][x] * 0.2
    end

    # generate inner probability
    @new_layout[y][x] += value * 0.2 * (borders + 1)
  end


  def position_probability x, y
    @layout[y][x]
  end

  def generate_layout
    [
        [0.0, 0.0, 0.0, 0.0, 0.0],
        [0.0, 0.0, 0.0, 0.0, 0.0],
        [0.0, 0.0, 0.0, 0.0, 0.0],
        [0.0, 0.0, 0.0, 0.0, 0.0],
        [0.0, 0.0, 0.0, 0.0, 0.0]
    ]
  end

  def outer_probabilities
    probability = 0
    probability += @layout[0].reduce(:+)
    probability += @layout[4].reduce(:+)
    @layout[1..3].each do |array|
      probability += array[0]
      probability += array[4]
    end
    probability
  end

  def total
    total = 0
    @layout.each do |row|
      total += row.reduce(:+)
    end
    total
  end
end
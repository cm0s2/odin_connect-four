# frozen_string_literal: true

class Board
  def initialize(columns = 7, rows = 6)
    @grid = Array.new(columns) { Array.new(rows) }
  end

  def full?
    @grid.flatten.include?(nil) ? false : true
  end

  def full_column?(column)
    @grid[column].include?(nil) ? false : true
  end

  def columns
    @grid.count
  end

  def rows
    @grid[0].count
  end

  def check_rows(n = 4)
    check_horizontal(n) || check_vertical(n) || check_diagonal(n)
  end

  def check_horizontal(n = 4)
    # loop over rows
    for r in 0...rows do
      count = 1
      cur_value = nil

      # loop over columns:
      for c in 0...columns do

        if @grid[c][r].nil?
          count = 1
          cur_value = nil
          next
        end

        if @grid[c][r] == cur_value
          count = count + 1
        else
          count = 1
          cur_value = @grid[c][r]
        end
        return cur_value if count >= n
      end
    end

    return nil
  end

  def check_vertical(n = 4)

    for c in 0...columns do
      count = 1
      cur_value = nil

      # loop over columns:
      for r in 0...rows do

        if @grid[c][r].nil?
          count = 1
          cur_value = nil
          next
        end

        if @grid[c][r] == cur_value
          count = count + 1
        else
          count = 1
          cur_value = @grid[c][r]
        end
        return cur_value if count >= n
      end
    end

    return nil
  end

  def check_diagonal(n = 4)
    # recursion?
    for c in 0...columns do
      for r in 0...rows do
        current_value = @grid[c][r]
        next if current_value.nil?

        return current_value if diagonal_recursion(1, c, r) >= n
        return current_value if diagonal_recursion(-1, c, r) >= n
      end
    end

    return nil
  end

  def diagonal_recursion(direction, c, r)
    return 1 if @grid[c + direction].nil?

    current_value = @grid[c][r]
    next_value = @grid[c + direction][r + 1]

    return 1 if current_value != next_value 

    return 1 + diagonal_recursion(direction, c + direction, r + 1)

    # return 0 if @grid[c][r].nil?

    # return diagonal_recursion(direction, c + direction, r + direction)
  end

  def place_mark(column, mark)
    return if full_column?(column)
    
    row_index = @grid[column].count(nil) - 1

    @grid[column][row_index] = mark
    # 
  end

  def draw
  puts
    for r in 0...rows do
      for c in 0...columns do
        cell = @grid[c][r]
        print cell.nil? ? '-' : cell
        print ' '
      end
      puts
    end
    puts
  end
end
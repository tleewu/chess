require "colorize"
require_relative "cursorable"

class Display
  include Cursorable

  def initialize(board)
    @board = board
    @cursor_pos = [0, 0]
  end

  def build_grid
    @board.rows.map.with_index do |row, i|
      build_row(row, i)
    end
  end

  def build_row(row, i)
    row.map.with_index do |piece, j|
      color_options = colors_for(i, j)
      piece.to_s.colorize(color_options)
    end
  end

  def colors_for(i, j)
    if [i, j] == @cursor_pos
      bg = :light_red
    elsif (i + j).odd?
      bg = :light_blue
    else
      bg = :green
    end
    { background: bg, color: @board.piece_at_position([i,j]).color }
  end

  def render
    system("clear")
    puts "Arrow keys, WASD, or vim to move, space or enter to confirm."
    puts "   " + ("A".."H").to_a.join("  ") + "   " + @board.captured_white.join("")
    build_grid.each_with_index { |row,row_idx| puts "#{row_idx} " + row.join + " #{row_idx}" }
    puts "   " + ("A".."H").to_a.join("  ") + "   " + @board.captured_black.join(" ")
  end

  def move
    result = nil
    until result
      render
      result = get_input
    end
    result
  end
end

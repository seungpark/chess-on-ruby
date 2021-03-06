require 'colorize'
require_relative "cursorable"

class Display
  include Cursorable

  def initialize(board)
    @board = board
    @cursor_pos = [board.grid.length - 1, 0]
    @selected = nil
    @second_selection = nil
  end

  def build_grid
    @board.grid.map.with_index do |row, i|
      build_row(row, i)
    end
  end

  def build_row(row, i)
    row.map.with_index do |piece, j|
      color_options = colors_for(i, j)
      piece ||= "   "
      piece.to_s.colorize(color_options)
    end
  end

  def colors_for(i, j)
    if [i, j] == @cursor_pos
      bg = :light_red
    elsif [i, j] == @selected
      bg = :blue
    elsif (i + j).odd?
      bg = :light_black
    else
      bg = :light_white
    end
    { background: bg }
  end

  def render
    system("clear")
    puts "Arrow keys to move, space or enter to confirm, s to save."
    build_grid.each { |row| puts row.join }
    nil
  end

  def run
    while true
      render
      get_input
    end
  end
end

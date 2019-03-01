# this gem injects a color method to the string when it is displayed by console
require 'colorize' 

def draw_cell(cell, index)
  return (index + 1).to_s.white if cell == 0
  return "0".yellow if cell == -1
  return "X".blue if cell == 1
end

def draw_tic(arr)
  size_line = 13
  line, col = "-".green, "|".green
  border = line * size_line
  total = border
  row = col
  arr.each_with_index do |cell, index|
    content = draw_cell(cell, index)
    row = row + " #{content} #{col}"
    if ((index + 1) % 3 == 0)
      total = total + "\n" + row + "\n" + border
      row = col
    end
  end
  puts total
end

def finish_game?(arr)
  (arr - [0, 1]).empty?
end

def who_wins?(g_state)

  reduced_game = []

  reduced_game[0] = g_state[0] + g_state[1] + g_state[2]
  reduced_game[1] = g_state[3] + g_state[4] + g_state[5]
  reduced_game[2] = g_state[6] + g_state[7] + g_state[8]

  reduced_game[3] = g_state[0] + g_state[3] + g_state[6]
  reduced_game[4] = g_state[1] + g_state[4] + g_state[7]
  reduced_game[5] = g_state[2] + g_state[5] + g_state[8]

  reduced_game[6] = g_state[0] + g_state[4] + g_state[8]
  reduced_game[7] = g_state[2] + g_state[4] + g_state[6]

  if reduced_game.include?(3)
    return 'x'
  elsif reduced_game.include?(-3)
    return 'o'
  else 
    return '-'
  end
end

def main
  game_state = Array.new(9, 0)
  draw_tic game_state
  puts "Elegi una opcion"
  puts who_wins?(game_state)
end

# execute program
main

# this gem injects a color method to the string when it is displayed by console
require 'colorize' 

def draw_cell(cell, index)
  return (index + 1).to_s.white if cell == 0
  return "O".yellow if cell == -1
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
  arr.include?(0)
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

def turn_machine(arr)
  positions = []
  arr.each_with_index do |num, index|
    positions.push(index) if num == 0
  end
  positions.sample
end

def main
  game_state = Array.new(9, 0)
  band = true
  winner = '-'
  while finish_game?(game_state)
    if band
      draw_tic game_state
      index = 0
      loop do 
        puts "Elige una opcion:"
        index = gets.chomp.to_i
        break if game_state[index - 1] == 0
        puts "Maldito bastardo elige bien".red
      end
      game_state[index - 1] = 1
      band = false
    else
      game_state[turn_machine(game_state)] = -1 
      band = true
    end
    winner = who_wins? game_state
    break if winner != '-'
  end
  draw_tic game_state
  if (winner == '-')
    puts "Empataste"
  else
    puts winner == "x" ? "Ganaste tio, alegrate".cyan : "Acabas de perder con una maquina".red
  end
end

# execute program
main

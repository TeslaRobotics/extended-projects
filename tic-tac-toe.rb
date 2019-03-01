# this gem injects a color method to the string when it is displayed by console
require 'colorize' 

def draw_cell(cell, index)
  return (index + 1).to_s.white if cell == 0
  return "@".yellow if cell == -1
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

def get_index(arr, val)
  arr.map.with_index { |num, index| index if num == val}.compact
end

def who_wins?(g_state)
  winConditions = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6],
  ];

  winConditions.each_with_index do |win, index|
    return 'x' if (win - get_index(g_state, 1)).empty?
    return 'o' if (win - get_index(g_state, -1)).empty?
  end

  return '-'
  
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
        break if  game_state[index - 1] == 0
        puts index > 9 ? "Del 1 al nueve, no sabes leer xd".red : "Maldito bastardo elige bien".red
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

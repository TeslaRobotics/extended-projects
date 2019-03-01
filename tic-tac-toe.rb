

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
  game_state = [0,0,0,-1,-1,0,0,0,0]
  who_wins?(game_state)
end

main
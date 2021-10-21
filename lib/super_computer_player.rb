require_relative 'tic_tac_toe_node'

class SuperComputerPlayer < ComputerPlayer
  def move(game, mark)
    startingNode = TicTacToeNode.new(game.board, mark)
    childNodes = startingNode.children()
    childNodes.each do |child|
      if child.winning_node?(mark)
        return child.prev_move_pos
      end
    end
    childNodes.each do |child|
      if !child.losing_node?(mark)
        return child.prev_move_pos
      end
    end
    raise "BIG ISSUES"
  end
end

if __FILE__ == $PROGRAM_NAME
  puts "Play the brilliant computer!"
  hp = HumanPlayer.new("Jeff")
  cp = SuperComputerPlayer.new

  TicTacToe.new(hp, cp).run
end

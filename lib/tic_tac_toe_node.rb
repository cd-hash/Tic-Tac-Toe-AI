require 'byebug'
require_relative 'tic_tac_toe'

class TicTacToeNode
  attr_accessor :board , :next_mover_mark, :prev_move_pos

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator) #evaluator should always be the computer's mark
    if self.board.over?
      if self.board.winner == evaluator
        return false
      elsif self.board.tied?
        return false
      else
        return true
      end
    else
      childNodes = self.children()
      childNodes.each do |child|
        # debugger
        if child.losing_node?(evaluator) # if any child gives the opponent a chance to win node loses
          return true
        end
      end
      return false # exited loop with no way for the opponent to win
    end
  end

  def winning_node?(evaluator)
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    emptyTiles = []
    children = []
    for row in 0...3
      for col in 0...3
        if @board.empty?([row,col])
          emptyTiles << [row, col]
        end
      end
    end
    emptyTiles.each do |tile|
      newBoard = self.board.dup
      nextMark = ((self.next_mover_mark == :x) ? :o : :x)
      newBoard[tile] = self.next_mover_mark
      newNode = TicTacToeNode.new(newBoard, nextMark, tile)
      children << newNode
    end
    return children
  end
end


if __FILE__ == $PROGRAM_NAME
  node = TicTacToeNode.new(Board.new, :o)
  node.board[[0, 0]] = :x
  node.board[[0, 1]] = :x
  node.board[[0, 2]] = :o
  node.board[[1, 1]] = :o
  node.board[[1, 0]] = :x
  node.losing_node?(:x) #should return true
end
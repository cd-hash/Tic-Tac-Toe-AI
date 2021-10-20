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
      else
        return true
      end
    else
      childNodes = self.children()
      childNodes.each do |child|
        # debugger
        child.losing_node?(child.next_mover_mark)
      end
      return false
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
      newBoard[tile] = nextMark
      newNode = TicTacToeNode.new(newBoard, nextMark, tile)
      children << newNode
    end
    return children
  end
end

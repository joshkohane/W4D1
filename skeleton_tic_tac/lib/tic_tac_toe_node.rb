require_relative 'tic_tac_toe'
require "byebug"
class TicTacToeNode
  attr_accessor :board, :next_mover_mark, :prev_move_pos
  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board #rows 
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
    #current node, go through all children until it hits the end and finds only loosing nodes
    #evaluator is you
    # debugger
    return false if @board.tied?
    return @board.winner != evaluator if @board.over? 
    
    #return  false if @board.over? && @board.winner == evaluator
    if @next_mover_mark == evaluator
      return self.children.all? do |child|
        child.losing_node?(evaluator)
      end
    end

    if @next_mover_mark != evaluator
      return self.children.any? do |child|
        child.losing_node?(evaluator)
      end
    end

    # if @board.won? && @board.winner != evaluator
    #   return true
      #checking if the park placed is a losing node,
      #checking this node and all of that nodes children to see if its at a loss
      #if there is a chance of winning, place a mark
  end


  def winning_node?(evaluator)
    return @board.winner == evaluator if @board.over?
    if @next_mover_mark == evaluator
      return children.any? { |child| child.winning_node?(evaluator) }
    end
    if @next_mover_mark != evaluator
      return children.all? { |child| child.winning_node?(evaluator) }
    end
    #eval is you
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    kids = []
    @board.rows.each_with_index do |row, i1|
      row.each_with_index do |el, i2|
        if @board.empty?([i1,i2])
            child_board = @board.dup
            #debugger
            child_board[[i1,i2]] = @next_mover_mark
          if next_mover_mark == :x
            kids << TicTacToeNode.new(child_board, :o, [i1, i2])
          else
            kids << TicTacToeNode.new(child_board, :x, [i1, i2])
          end
        end
      end
    end
    kids

      #every empty space on the board we will create a child
    #we want a nested loop where we iterate through the rows and the columns
    #then if space == empty then we create a node where we pass in all of the same things
    #place mark takes in a pos and a marker, so at every position we place a mark at that pos
    #and then we set prev move pos to that position
  end
end

require_relative "skeleton/lib/00_tree_node.rb"
require "byebug"

class KnightPathFinder
    attr_reader :root_node

    def self.valid_moves(pos)
        moves = []
        x = pos.first
        y = pos.last
        moves << [x+2, y+1] << [x+2, y-1] << [x-2, y+1] << [x-2, y-1]
        moves << [x+1, y+2] << [x+1, y-2] << [x-1, y+2] << [x-1, y-2]
        moves.select{|move| valid_position?(move)}
    end

    def self.valid_position?(pos)
        return 0 <= pos.first && pos.first <= 7 && 0 <= pos.last && pos.last <= 7
    end

    def initialize(start)
        @root_node = PolyTreeNode.new(start)
        @considered_positions = [root_node.value]
    end

    def new_move_positions(pos)
        new_arr = KnightPathFinder.valid_moves(pos).reject { |position| @considered_positions.include?(position) }
        @considered_positions += new_arr
        new_arr
    end

    def build_move_tree
        queue = [root_node]
        until queue.empty?
            dequeue = queue.shift
            new_moves = new_move_positions(dequeue.value)
            new_moves.each do |move| 
                child = PolyTreeNode.new(move)
                dequeue.add_child(child) 
                queue << child
            end            
        end
    end

    def find_path(end_pos)
        node = self.root_node.dfs(end_pos)
        node.nil? ? (raise "No end position found") : (trace_path_back(node))
    end
    
    def trace_path_back(end_node)
        queue = [end_node]
        until queue.first.parent== nil
            queue.unshift(queue.first.parent)
        end
        queue.map{|el| el.value}
    end

end

       
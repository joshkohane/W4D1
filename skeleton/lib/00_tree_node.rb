class PolyTreeNode
    attr_reader :value, :parent, :children
    def initialize(value)
        @value = value
        @parent = nil
        @children = []
    end

    def parent=(node)
        @parent.children.delete(self) if parent != nil
        @parent = node
        node.children << self if parent != nil
    end

    def add_child(child)
        if child.parent != self
            child.parent = self
        end
    end
    
    def remove_child(child)
        if self.children.include?(child)
            child.parent = nil
        else
            raise 'Node is not a child'
        end
    end

    def dfs(value)
        return self if self.value == value
        self.children.each do |child| 
            result = child.dfs(value) 
            return result if result != nil
        end
        nil
    end
    def bfs(value)
        queue = [self]
        until queue.empty?
            dequeue = queue.shift
            return dequeue if dequeue.value == value
            queue.concat(dequeue.children)
        end
        nil
    end
end
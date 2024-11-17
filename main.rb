require 'set'

RELATIVE_MOVES = [1, -1, 2, -2].permutation(2).filter { |x, y| x != -y }
BOARD_SIZE = 8

def knight_moves(start_pos, end_pos)
  # A queue worklist - the next element is an array containing the next position, and the path to this position
  todo = [[start_pos, [start_pos]]]

  # Can use an array, but a set is more efficient here since we only need lookup
  visited = Set.new([start_pos])

  until todo.empty?
    current_pos, path = todo.shift

    # Since we're using bfs, we only get to the next level of depth after checking all adjacent vertices,
    # and therefore the shortest path is guaranteed to be the first path we find
    return path if current_pos == end_pos

    todo.concat(next_moves(current_pos, path, visited))
  end
end

def next_moves(current_pos, path, visited)
  moves(current_pos).filter_map do |pos|
    unless visited.include? pos
      visited << pos
      [pos, path + [pos]]
    end
  end
end

def moves(pos)
  RELATIVE_MOVES.filter_map do |relative_pos|
    new_pos = sum_pos(pos, relative_pos)
    new_pos if valid_pos? new_pos
  end
end

def sum_pos(p1, p2)
  [p1[0] + p2[0], p1[1] + p2[1]]
end

def valid_pos?(pos)
  pos.all? { |index| index >= 0 && index < BOARD_SIZE }
end

p knight_moves([0, 0], [1, 2])
p knight_moves([0, 0], [3, 3])
p knight_moves([0, 0], [7, 7])

# frozen_string_literal: true

require 'set'

# Represents all moves a knight can make relative to a position
RELATIVE_MOVES = [1, -1, 2, -2].permutation(2).filter { |x, y| x != -y }

BOARD_SIZE = 8

def knight_moves(start_pos, end_pos)
  path = find_minimum_path(start_pos, end_pos)
  puts "You made it in #{path.size - 1} moves!  Here's your path:"
  path.each { |pos| puts pos.inspect }
end

def find_minimum_path(start_pos, end_pos)
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

# All valid concrete moves from a given position
def moves(pos)
  RELATIVE_MOVES.filter_map do |move|
    new_pos = [pos[0] + move[0], pos[1] + move[1]]
    new_pos if valid_pos? new_pos
  end
end

def valid_pos?(pos)
  pos.all? { |index| index >= 0 && index < BOARD_SIZE }
end

knight_moves([0, 0], [1, 2])
knight_moves([0, 0], [3, 3])
knight_moves([0, 0], [7, 7])

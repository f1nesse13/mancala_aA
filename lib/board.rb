require_relative 'player'
require 'byebug'
class Board
  attr_accessor :cups

  def initialize(name1, name2)
    @name1 = name1
    @name2 = name2
    @cups = place_stones
  end

  def place_stones
    arr = Array.new(14) { [] }
    arr.each_with_index do |cup, i|
      if i == 6 || i == 13
        next
      else
        4.times { cup << :stone } 
      end
    end 
    arr
    # helper method to #initialize every non-store cup with four stones each
  end

  def valid_move?(start_pos)
    if start_pos < 0 || start_pos > 13
      raise "Invalid starting cup"
    elsif @cups[start_pos].empty?
      raise "Starting cup is empty"
    elsif start_pos != 6 || start_pos != 13
      raise "You cannot start on a point cup"
    end
  end

  def make_move(start_pos, current_player_name)
    stones = @cups[start_pos].count
    @cups[start_pos] = []
    current_index = start_pos + 1
      while stones > 0
        if current_index == 6
          if current_player_name == @name2
            current_index += 1
            next
          end
        end
        if current_index == 13 
          if current_player_name == @name1
            current_index += 1
            next
          end
        end
          @cups[current_index] << :stone
          stones -= 1
          if current_index == 13
            current_index = 0
          end
          current_index += 1
        end
      render
      # next_turn
  end

  def next_turn(ending_cup_idx)
    # helper method to determine whether #make_move returns :switch, :prompt, or ending_cup_idx
  end

  def render
    print "      #{@cups[7..12].reverse.map { |cup| cup.count }}      \n"
    puts "#{@cups[13].count} -------------------------- #{@cups[6].count}"
    print "      #{@cups.take(6).map { |cup| cup.count }}      \n"
    puts ""
    puts ""
  end

  def one_side_empty?
  end

  def winner
  end
end

# a = Board.new("Joe", "Liz")
# a.make_move(4, "Joe")
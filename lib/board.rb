require_relative 'player'
require 'byebug'
class Board
  attr_accessor :cups

  def initialize(name1, name2)
    @name1 = name1
    @name2 = name2
    @cups = Array.new(14) { [] }
    place_stones
  end

  def place_stones
    @cups.each_with_index do |cup, i|
      if i == 6 || i == 13
        next
      else
        4.times { cup << :stone } 
      end
    end 
    @cups
    # helper method to #initialize every non-store cup with four stones each
  end

  def valid_move?(start_pos)
    if start_pos < 0 || start_pos >= 13
      raise "Invalid starting cup"
    elsif @cups[start_pos].empty?
      raise "Starting cup is empty"
    elsif start_pos == 6
      raise "Invalid starting cup"
    end
  end

  def make_move(start_pos, current_player_name)
    stones = @cups[start_pos].count
    @cups[start_pos] = []
    current_index = start_pos
      until stones == 0
        current_index += 1
        current_index = 0 if current_index > 13
        next if current_player_name == @name2 && current_index == 6
        next if current_player_name == @name1 && current_index == 13
          @cups[current_index] << :stone
          stones -= 1        
        end
        render
        return next_turn(current_index)
  end

  def next_turn(ending_cup_idx)
    # helper method to determine whether #make_move returns :switch, :prompt, or ending_cup_idx
    end_stones = @cups[ending_cup_idx].count
    return :prompt if ending_cup_idx == 6
    return :prompt if ending_cup_idx == 13
    return end_stones == 1 ? :switch : ending_cup_idx
     
  end

  def render
    print "      #{@cups[7..12].reverse.map { |cup| cup.count }}      \n"
    puts "#{@cups[13].count} -------------------------- #{@cups[6].count}"
    print "      #{@cups.take(6).map { |cup| cup.count }}      \n"
    puts ""
    puts ""
  end

  def one_side_empty?
    @cups[7..12].all?(&:empty?) || @cups[0..5].all?(&:empty?)
  end

  def winner
    case @cups[6] <=> @cups[13]
    when -1
      @name2
    when 0
      :draw
    else
      @name1
    end
  end
end

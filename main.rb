# frozen_string_literal: true

# 4 pegs, 6 colors
# "colors" 1-6
# code example: '1234', '3456', '1122'

# Game Class
class Game
  def initialize
    @code = generate_code
    @turns_left = 12
  end

  attr_reader :code, :turns_left

  def play
    loop do
      puts "Turns left: #{@turns_left}"
      @turns_left -= 1
      return if turns_left.zero?
    end
  end

  def generate_code
    code_arr = []
    4.times do
      code_arr << rand(1..6)
    end
    code_arr
  end
end

class Player

end

class HumanPlayer < Player

end

class ComputerPlayer < Player

end

Game.new.play

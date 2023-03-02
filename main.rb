# frozen_string_literal: true

# 4 pegs, 6 colors
# "colors" 1-6
# code example: '1234', '3456', '1122'

# Game Class
class Game
  def initialize
    @code = generate_code
    @turn_count = 1
  end

  attr_reader :code, :turn_count

  def play
    loop do
      guess = make_guess
      if check_guess(guess)
        puts 'You Win!'
        return
      end
      return unless increment_turn
    end
  end

  def make_guess
    print "Guess #{@turn_count}: "
    gets.chomp.split('').map(&:to_i)
  end

  def check_guess(guess)
    return true if guess == @code
  end

  def increment_turn
    @turn_count += 1
    return true unless @turn_count > 12

    puts 'Game Over'
  end

  def generate_code
    code_arr = []
    4.times do
      code_arr << rand(1..6)
    end
    p code_arr
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

# frozen_string_literal: true

# 4 pegs, 6 colors
# "colors" 1-6
# code example: '1234', '3456', '1122'

# Game Class
class Game
  @@intro = "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n" \
            "|                             |\n" \
            "|     M A S T E R M I N D     |\n" \
            "|                             |\n" \
            "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n" \
            "\nHit: Correct Color & Position\n" \
            "Blow: Correct Color Only\n" \
            "\n------------------------------"

  def initialize
    @code = generate_code
    @guess = []
    @turn_count = 1
    @hits = 0
    @blows = 0
  end

  # attr_reader :code, :turn_count

  def play
    puts @@intro
    loop do
      @guess = make_guess
      if check_guess
        puts "\nYou Win! Code Guessed in #{@turn_count} Moves."
        return
      end
      puts "\nHits: #{@hits} Blows: #{@blows}"
      return unless increment_turn
    end
  end

  def make_guess
    print "\nGuess #{@turn_count}: "
    gets.chomp.split('').map(&:to_i)
  end

  def check_guess
    return true if @guess == @code

    @temp_guess = @guess.dup
    @temp_code = @code.dup

    check_hits(@temp_guess, @temp_code)
    check_blows(@temp_guess, @temp_code)
    p @temp_guess
    p @temp_code
    p @code

    false
  end

  def check_hits(guess, code)
    guess.each_with_index do |n, i|
      next unless n == code[i]

      @hits += 1
      @temp_guess.delete_at(i)
      @temp_code.delete_at(i)
    end
  end

  def check_blows(guess, code)
    guess.each_with_index do |x, x_ind|
      code.each_with_index do |y, y_ind|
        next unless x == y

        @blows += 1
        @temp_guess.delete_at(x_ind)
        @temp_code.delete_at(y_ind)
      end
    end
  end

  def increment_turn
    @turn_count += 1
    @hits = 0
    @blows = 0
    return true unless @turn_count > 12

    puts "\nGame Over. The Code Was #{@code.join}."
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

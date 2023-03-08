# frozen_string_literal: true

# Game Class
class Game
  def initialize(codemaker_class, codebreaker_class)
    @codemaker = codemaker_class.new
    @codebreaker = codebreaker_class.new
    @code = @codemaker.generate_code
    @guess = []
    @turn_count = 1
    @hits = 0
    @blows = 0
  end

  attr_reader :code, :turn_count

  def play
    p @code
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

    false
  end

  def check_hits(guess, code)
    guess.each_with_index do |n, i|
      next unless n == code[i]

      @hits += 1
      @temp_guess[i] = -1
      @temp_code[i] = -2
    end
  end

  def check_blows(guess, code)
    guess.each_with_index do |x, x_ind|
      code.each_with_index do |y, y_ind|
        next unless x == y

        @blows += 1
        @temp_guess[x_ind] = -1
        @temp_code[y_ind] = -2
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

end

class Player

end

# Human Player Class
class HumanPlayer < Player
  def generate_code
    print "\nPlease Input A Code: "
    gets.chomp.split('').map(&:to_i)
  end
end

# Computer Player Class
class ComputerPlayer < Player
  def generate_code
    puts "\nThe Computer Has Picked A Code!"
    code_arr = []
    4.times do
      code_arr << rand(1..6)
    end
    # p code_arr
    code_arr
  end
end

puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n" \
     "|                             |\n" \
     "|     M A S T E R M I N D     |\n" \
     "|                             |\n" \
     "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n" \
     "\n- 4 Digits, Numbers 1-6" \
     "\n- Possible Duplicates" \
     "\n- Hit: Correct Number & Position" \
     "\n- Blow: Correct Number Only\n" \
     "\n-------------------------------"

print "\nCodemaker or Codebreaker? (1 or 2): "
player_selection = gets.chomp.to_i
if player_selection == 1
  codemaker = HumanPlayer
  codebreaker = ComputerPlayer
else
  codemaker = ComputerPlayer
  codebreaker = HumanPlayer
end

Game.new(codemaker, codebreaker).play

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
    loop do
      print "\nGuess #{@turn_count}: "
      @guess = @codebreaker.make_guess(@code)
      if check_guess
        announce_winner
        return
      end
      puts "\nHits: #{@hits} Blows: #{@blows}"
      return unless increment_turn
    end
  end

  def announce_winner
    puts "\nYou Win! Code Guessed in #{@turn_count} Moves."
  end

  def check_guess
    return true if @guess == @code

    @temp_guess = @guess.dup
    @temp_code = @code.dup

    check_hits(@temp_guess, @temp_code)
    check_blows(@temp_guess, @temp_code)
    sleep(0.5)
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

# Human Player Class
class HumanPlayer
  def generate_code
    print "\nPlease Input A Code: "
    gets.chomp.split('').map(&:to_i)
  end

  def make_guess(_)
    gets.chomp.split('').map(&:to_i)
  end
end

# Computer Player Class
class ComputerPlayer
  def initialize
    @init_guess = [1, 1, 1, 1]
    @current_guess = [0, 0, 0, 0]
    @turn_count = 1
  end

  def generate_code
    puts "\nThe Computer Has Picked A Code!"
    rand_code
  end

  def rand_code
    code_arr = []
    4.times do
      code_arr << rand(1..6)
    end
    code_arr
  end

  def make_guess(code)
    @current_guess = new_guess(code)
    sleep(0.5)
    puts @current_guess.join
    @turn_count += 1
    @current_guess
  end

  def new_guess(code)
    return @init_guess if @turn_count == 1

    @current_guess.each_with_index do |n, i|
      @current_guess[i] += 1 unless n == code[i]
    end

    @current_guess
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

new_game = Game.new(codemaker, codebreaker)
new_game.play

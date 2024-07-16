require 'yaml'

class Game
  attr_accessor :word_array, :total_guesses, :current_guess, :guessed_word_array, :incorrect_guesses

  def initialize
    @word_array = load_word.split('')
    @total_guesses = 6
    @current_guess = 0
    @guessed_word_array = Array.new(@word_array.length, '_')
    @incorrect_guesses = []
  end

  def load_word
    words = File.readlines('google-10000-english-no-swears.txt').map(&:chomp)
    words.select { |word| word.length.between?(5, 12) }.sample
  end

  def play_game
    puts "\nWelcome to Hangman!"
    puts "The word is ready!"

    until game_over?
      display_game_state
      puts "\nMake a guess, or input 'save' to save the game:"
      input = gets.chomp.downcase

      if input == 'save'
        save_game
        puts '\nGame saved!'
        return
      elsif input.length == 1 && input.match?(/[a-z]/)
        make_guess(input)
      else
        puts "Invalid input. Please enter a single letter or 'save'."
      end
    end

    display_game_result
  end

  def make_guess(letter)
    if @word_array.include?(letter)
      update_guessed_word(letter)
      puts "Correct guess!"
    else
      @incorrect_guesses << letter unless @incorrect_guesses.include?(letter)
      @current_guess += 1
      puts "Incorrect guess!"
    end
  end

  def update_guessed_word(letter)
    @word_array.each_with_index do |char, index|
      @guessed_word_array[index] = letter if char == letter
    end
  end

  def display_game_state
    puts "\nWord: #{@guessed_word_array.join(' ')}"
    puts "Incorrect guesses: #{@incorrect_guesses.join(', ')}"
    puts "Remaining guesses: #{@total_guesses - @current_guess}"
  end

  def game_over?
    @current_guess >= @total_guesses || !@guessed_word_array.include?('_')
  end

  def display_game_result
    if @guessed_word_array.include?('_')
      puts "\nGame over! You ran out of guesses."
      puts "The word was: #{@word_array.join}"
    else
      puts "\nCongratulations! You guessed the word: #{@word_array.join}"
    end
  end

  def save_game
    File.open('saved_game.yml', 'w') { |file| file.write(YAML.dump(self)) }
    puts "Game saved successfully!"
  end

  def self.load_game
    YAML.safe_load(File.read('saved_game.yml'), permitted_classes: [Game, Symbol])
  rescue Errno::ENOENT
    puts "No saved game found."
    nil
  end
end

# Main game loop
puts "Welcome to Hangman!"
puts "1. New Game"
puts "2. Load Game"
choice = gets.chomp

game = if choice == '2'
         Game.load_game || Game.new
       else
         Game.new
       end

game.play_game

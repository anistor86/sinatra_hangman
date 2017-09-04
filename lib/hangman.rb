class Game

  attr_accessor :guessed, :guessing, :lives, :message, :status
  attr_reader :to_guess

# initialize the program
  def initialize
    @guessed = []
    @to_guess = get_word
    @guessing = Array.new(@to_guess.length, "_")
    @lives = 10
    @message = ""
    @status = ""
  end

# load the list of word from the file, select the word between 5 & 12 chars
# choose one word randomly from the array with sample
  def get_word
    words = File.readlines("lib/5desk.txt")
    words.each { |word| word.chomp! }
    words_list = words.select { |word| word.length.between?(5, 12)}

    words_list.sample.downcase.split("")
  end

# check if the letter is in the word to guess
  def check(guess)
    correct = 0

    if @guessed.include?(guess)
      @message = "Choose another letter!"
    else
      @message = ""
      @guessed << guess
      @to_guess.each_with_index do |char, index|
        if guess == char
          @guessing[index] = guess
          correct += 1
        end
      end
      @lives -= 1 if correct == 0
    end

    if @guessing.join == @to_guess.join
      @message = "#{@guessing.join} was the word. You won!!"
      @status = "disabled"
    end
    if @lives == 0
      @message = "No lives left! You lost! The word was: \"#{@to_guess.join}\""
      @status = "disabled"
    end

  end

# reset all the instance variables
  def reset
    @guessed = []
    @to_guess = get_word
    @guessing = Array.new(@to_guess.length, "_")
    @lives = 10
  end

  def lives_left
    @lives
  end

  def chosen_letters
    @guessed.join(",")
  end

  def display_word
    @guessing.join(" ")
  end

  def status
    @message
  end

  def input_status
    @status
  end

end

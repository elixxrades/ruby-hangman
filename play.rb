class Hangman
  def initialize
    @word = words.sample
    @lives = 7

    @word_teaser = ""

    @word.first.size.times do
      @word_teaser += "_ "
    end
  end

  def words
    [
      ["speaker", "What music does it play for you?"],
      ["elixxrades", "What is my producer's username?"],
      ["bird", "a flying animal"],
      ["youtube", "video sharing platform"],
      ["lol", "a cancerous game"],
    ]
  end

  def print_teaser(last_guess = nil)
    update_teaser(last_guess) unless last_guess.nil?
    puts @word_teaser
  end

  def update_teaser(last_guess)
    new_teaser = @word_teaser.split

    new_teaser.each_with_index do |letter, index|
      if letter == "_" && @word.first[index] === last_guess
        new_teaser[index] = last_guess
      end
    end
    @word_teaser = new_teaser.join(" ")
  end

  def make_guess
    if @lives > 0
      puts "Enter a letter"
      guess = gets.chomp
      if guess.length > 1
        puts "You can specify a maximum of 1 letter."
        make_guess
      end
      good_guess = @word.first.include? guess

      if guess == "exit"
        puts "Thank your for playing!"
      elsif good_guess
        puts "> You are correct!"

        print_teaser guess

        if @word.first == @word_teaser.split.join
          puts "Congratulations... you have won this round!"
        else
          make_guess
        end
      else
        @lives -= 1
        puts "> Sorry... you have #{@lives} lives left. Try again!"
        make_guess
      end
    else
      puts "> Game over.."
    end
  end

  def begin
    puts "> New game started. Your word is #{@word.first.size} characters long"

    puts "> To exit game at any point type 'exit'"

    print_teaser

    puts "> Your clue is \"#{@word.last}\""

    make_guess
  end
end

game = Hangman.new
game.begin

require_relative 'lib/secret_word'
require_relative 'lib/game'

# Option to load a saved game
puts "Do you want to load a saved game (yes?no)"
load_game = gets.chomp.downcase

if load_game == 'yes'
    game = Game.load_game
    if game.nil?
        puts "No saved game found. Starting a new game..."
    end
end

# Create a new game if no saved game was loaded
unless game
    puts "Starting a new game..."
    #Create an instance of SecretWord to get a word
    secret_word_instance = SecretWord.new

    # Retrieve the secret word from SecretWord instance
    secret_word = secret_word_instance.word_to_find

    # Pass the secret word to the Game instance
    game = Game.new(secret_word)
else
    secret_word = game.word_to_find
end


puts "the game begin: "
game.display

#main game loop 
while game.number_of_try > 0 
    guessed_letter = game.guess_user
    break if guessed_letter.nil? # Exit loop if game was saved
    game.inside_or_not(guessed_letter, secret_word.chars)
    game.display
    break if game.win? # Break the loop if the player has won
end

if game.win?
    puts "you won !!!"
else
    puts "you lose..."
    puts "the word to find was #{secret_word}"
end



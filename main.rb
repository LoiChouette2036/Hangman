require_relative 'lib/secret_word'
require_relative 'lib/game'

#Create an instance of SecretWord to get a word
secret_word_instance = SecretWord.new

# Retrieve the secret word from SecretWord instance
secret_word = secret_word_instance.word_to_find

# Pass the secret word to the Game instance
game = Game.new(secret_word)

game.display
game.guess_user
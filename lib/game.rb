require_relative 'secret_word'

class Game

    # initialize the game with the secret word
    def initialize(word_to_find)
        @word_to_find = word_to_find
        @array_to_discover = Array.new(@word_to_find.length,"_")
    end


    def display
        puts @array_to_discover.join(" ")
    end

    def guess_user
        puts "Choose one letter"
        @letter_guess = gets.chomp
    end

    def inside_or_not (user_guess, word_being_guessed)
        match_found = false
        word_being_guessed.each_with_index do |element, index|
            if element == user_guess
                @array_to_discover[index] = element
                match_found = true
            end            
        end
        puts "it's not inside" unless match_found
    end
end

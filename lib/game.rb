require_relative 'secret_word'

class Game

    attr_reader :number_of_try, :word_to_find

    # initialize the game with the secret word
    def initialize(word_to_find)
        @word_to_find = word_to_find
        @array_to_discover = Array.new(@word_to_find.length,"_")
        @number_of_try = 12
        @array_with_incorrect_guess = Array.new
    end


    def display
        puts @array_to_discover.join(" ")
        puts ""
    end

    def guess_user
        puts "Choose one letter or type 'save' to save the game"
        @letter_guess = gets.chomp.downcase
        if @letter_guess == 'save'
            save_game
            return nil
        end
        @letter_guess
    end

    #def save_game
    #    Dir.mkdir('saves') unless Dir.exist?('saves') # Create saves directory if it doesn't exist
    #    File.open('saves/hangman_save.txt', 'w') do |file|
    #        file.puts Marshal.dump(self) # Serialize the current game state
    #    end
    #    puts "Game saved!"
    #end
    def save_game
        Dir.mkdir('saves') unless Dir.exist?('saves') # Create saves directory if it doesn't exist
        puts "Enter a name for your save file:"
        save_name = gets.chomp
        File.open("saves/#{save_name}_hangman_save.txt", 'w') do |file|
            file.puts Marshal.dump(self) # Serialize the current game state
        end
        puts "Game saved as #{save_name}_hangman_save.txt!"
    end

    #def self.load_game
    #    if File.exist?('saves/hangman_save.txt')
    #        saved_game = File.open('saves/hangman_save.txt', 'r') {|file| Marshal.load(file)}
    #        puts "Game loaded!"
    #        return saved_game
    #    else
    #        puts "No saved game found."
    #        return nil
    #    end
    #end

    def self.load_game
        unless Dir.exist?('saves') && !Dir.empty?('saves')
            puts "No saved games found."
            return nil
        end
    
        save_files = Dir.glob('saves/*_hangman_save.txt')
        if save_files.empty?
            puts "No saved games found."
            return nil
        end
    
        puts "Available save files:"
        save_files.each_with_index { |file, index| puts "#{index + 1}: #{File.basename(file, '_hangman_save.txt')}" }
        puts "Enter the number of the save file you want to load:"
        file_index = gets.chomp.to_i - 1
    
        if file_index.between?(0, save_files.length - 1)
            saved_game = File.open(save_files[file_index], 'r') { |file| Marshal.load(file) }
            puts "Game loaded!"
            return saved_game
        else
            puts "Invalid selection."
            return nil
        end
    end
    

    #########################

    def inside_or_not (user_guess, word_being_guessed)
        return if user_guess.nil? # Exit the method if user_guess is nil

        user_guess.downcase!
        match_found = false
        word_being_guessed.each_with_index do |element, index|
            if element == user_guess
                @array_to_discover[index] = element
                match_found = true
            end            
        end
        unless match_found
            puts "it's not inside" 
            @array_with_incorrect_guess.push(user_guess)
            #puts "array of used letter #{@array_with_incorrect_guess}"
        end
        display
        puts "array of used letter #{@array_with_incorrect_guess}"
        @number_of_try -= 1;
    end

    def win?
        if @array_to_discover == @word_to_find.chars
            #puts "you have won"
            return true
        else
            puts "rounds left : #{@number_of_try}"
            return false
        end
    end
    
end
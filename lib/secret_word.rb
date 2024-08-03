class SecretWord

    attr_reader :word_to_find

    def initialize
        # Read all the words into an array
        contents = File.read('google-10000-english-no-swears.txt').split
        # Filter the array to only include words of certain lengths
        filtered_array = contents.select { |word| word.length >= 5 && word.length <= 12 }
        # Randomly select a word and store it as an instance variable
        @word_to_find = filtered_array.sample
    end

end




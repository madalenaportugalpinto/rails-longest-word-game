require "open-uri"

class GamesController < ApplicationController
  def new
    @letters = ('A'..'Z').to_a.sample(10)
  end

  def score
    @letters = params[:letters].chars
    url = "https://wagon-dictionary.herokuapp.com/#{params[:word]}"
    word_upcase = params[:word].upcase
    api = JSON.parse(URI.open(url).read)
    # params[:word].each do |letter|
    #   if @letters.include?(letter)
    word_upcase.chars.each do |letter|
      if @letters.include?(letter)
        @letters -= [@letters.delete_at(@letters.index(letter))]
      end
    end
    if 10 - @letters.reject{|a| a == " "}.length == word_upcase.length
      if api["found"]
        @answer = "Congratulations! #{word_upcase} is a valid English word!"
      else
        @answer = "Sorry! #{word_upcase} is not a valid English word!"
      end
    else
      @answer = "#{word_upcase} can’t be built out of the original grid"
    end
  end
end


# The word can’t be built out of the original grid ❌
# The word is valid according to the grid, but is not a valid English word ❌
# The word is valid according to the grid and is an English word ✅

require "json"
require "open-uri"

class GamesController < ApplicationController
  def new
    # @letters = ('a'..'z').to_a.sample(10)
    letterse = []
    10.times { letterse << ('a'..'z').to_a.sample }
    @letters = letterse
  end

  def score
    @word = params[:word]
    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    word_checked = JSON.parse(URI.open(url).read)
    if @word == '???'
      @result = "Sorry but #{@word.upcase} can't be built with #{@word.upcase}"
    elsif word_checked['found'] == true
      @score = @word.length * 100
      @result = "Congratulation! #{@word.upcase} is a valid English word! You won #{@score} points"
    elsif word_checked['error'] == 'word not found'
      @result = "Sorry but #{@word.upcase} does not seem to be a valid English word..."
    end
  end
end

class WordGuesserGame
  attr_accessor :word, :guesses, :wrong_guesses

  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end

  def guess(letter)
    raise ArgumentError if letter.nil? || letter.empty? || letter !~ /^[a-z]$/i

    letter = letter.downcase

    return false if @guesses.include?(letter) || @wrong_guesses.include?(letter)

    if @word.include?(letter)
      @guesses += letter
    else
      @wrong_guesses += letter
    end

    true
  end

  def word_with_guesses
    @word.chars.map { |ch| @guesses.include?(ch) ? ch : '-' }.join
  end

  def check_win_or_lose
    return :lose if @wrong_guesses.length >= 7
    return :win if @word.chars.all? { |ch| @guesses.include?(ch) }

    :play
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'

    uri = URI('https://randomword.saasbook.info/RandomWord')
    Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
      response = http.get(uri.path)
      return response.body.scan(/<div>(.+?)<\/div>/).flatten.first
    end
  end
end
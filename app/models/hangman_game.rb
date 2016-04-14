class HangmanGame
  attr_reader :solution, :max_tries, :correct_characters, :wrong_characters

  def initialize(solution:, max_tries: 11)
    @solution = solution
    @max_tries = max_tries
    @correct_characters = []
    @wrong_characters = []
  end

  def guess(character)
    if solution.include? character
      @correct_characters << character
    else
      @wrong_characters << character
    end
  end

  def word
    solution.gsub dot_matcher, '.'
  end

  def status
    if fail?
      :fail
    elsif success?
      :success
    else
      :busy
    end
  end

  def tries_left
    max_tries - wrong_characters.length
  end

  private
    def success?
      word == solution
    end

    def fail?
      tries_left == 0
    end

    def dot_matcher
      negate = correct_characters.any? ? correct_characters.join('|') : '.'
      Regexp.new "[^#{negate}]"
    end
end

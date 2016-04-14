class Game < ActiveRecord::Base
  SOLUTIONS = %w(
    teacher actor musician philosopher writer doctor accountant
    agriculturist architect economist engineer interpreter attorney advocate
    librarian statistician human resources firefighter judge officer astronomer
    biologist chemist physicist programmer developer designer
  ).freeze

  has_many :guesses, dependent: :destroy

  validates :solution, format: {
    with: /\A[a-z]+\z/,
    message: 'must be a single lowercase word'
  }

  def status
    hangman.status
  end

  def tries_left
    hangman.tries_left
  end

  def word
    hangman.word
  end

  def run
    guesses.pluck(:character).each do |character|
      hangman.guess character
    end
  end

  private
    def hangman
      @hangman ||= HangmanGame.new solution: solution
    end
end

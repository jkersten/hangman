class Guess < ActiveRecord::Base
  belongs_to :game

  validates :character, inclusion: {
    in: 'a'..'z',
    message: 'input must be a single lowercase letter'
  }
end

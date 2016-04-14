class CreateGuesses < ActiveRecord::Migration
  def change
    create_table :guesses do |t|
      t.belongs_to :game, index: true, foreign_key: true
      t.string :character, limit: 1

      t.timestamps null: false
    end
  end
end

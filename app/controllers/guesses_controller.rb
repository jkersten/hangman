class GuessesController < ApplicationController
  def create
    character = guess_params.fetch(:char)
    @game = Game.find params[:id]
    guess = @game.guesses.build character: character
    if guess.save
      render json: { message: "guessing #{character}" }, status: :created
    else
      render json: { errors: guess.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private
    def guess_params
      params.permit :char
    end
end

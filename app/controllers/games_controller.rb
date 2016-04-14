class GamesController < ApplicationController
  def index
    @games = Game.all
    @games.map &:run
  end

  def show
    @game = Game.find params[:id]
    @game.run
  end

  def create
    game = Game.new solution: game_params.fetch(:solution, Game::SOLUTIONS.sample)
    if game.save
      render json: { message: 'new game started' }, status: :created
    else
      render json: { errors: game.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private
    def game_params
      params.permit :solution
    end
end

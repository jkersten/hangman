require 'rails_helper'

RSpec.describe "Hangman API" do
  describe "playing a game" do
    it "works" do
      post '/games', solution: 'awesome'
      post '/games/1', char: 'a'
      post '/games/1', char: 'a'
      post '/games/1', char: 'e'
      post '/games/1', char: 'd'
      get '/games/1'

      expected = {
        "game" => {
          "id" => 1,
          "word" => "a.e...e",
          "status" => "busy",
          "tries_left" => 10
        }
      }

      expect(JSON.parse response.body).to eq expected
    end
  end

  describe "winning a game" do
    it "works" do
      post '/games', solution: 'awesome'
      post '/games/1', char: 'a'
      post '/games/1', char: 'b'
      post '/games/1', char: 'w'
      post '/games/1', char: 'e'
      post '/games/1', char: 's'
      post '/games/1', char: 's'
      post '/games/1', char: 'o'
      post '/games/1', char: 'm'
      post '/games/1', char: 'e'
      get '/games/1'

      expected = {
        "game" => {
          "id" => 1,
          "word" => "awesome",
          "status" => "success",
          "tries_left" => 10
        }
      }

      expect(JSON.parse response.body).to eq expected
    end
  end

  describe "loosing a game" do
    it "works" do
      post '/games', solution: 'aab'
      post '/games/1', char: 'b'
      post '/games/1', char: 'c'
      post '/games/1', char: 'd'
      post '/games/1', char: 'e'
      post '/games/1', char: 'f'
      post '/games/1', char: 'g'
      post '/games/1', char: 'h'
      post '/games/1', char: 'i'
      post '/games/1', char: 'j'
      post '/games/1', char: 'k'
      post '/games/1', char: 'l'
      post '/games/1', char: 'm'
      get '/games/1'

      expected = {
        "game" => {
          "id" => 1,
          "word" => "..b",
          "status" => "fail",
          "tries_left" => 0
        }
      }

      expect(JSON.parse response.body).to eq expected
    end
  end

  describe "invalid input" do
    it "rejects the request" do
      post '/games', solution: 'awesome'
      post '/games/1', char: 'A'

      expected = {
        "errors" => ["Character input must be a single lowercase letter"]
      }

      expect(JSON.parse response.body).to eq expected
    end
  end

  describe "listing all games" do
    it "rejects the request" do
      post '/games', solution: 'awesome'
      post '/games/1', char: 'a'
      post '/games/1', char: 'w'
      post '/games/1', char: 'e'

      post '/games', solution: 'fantastic'
      post '/games/2', char: 'e'
      post '/games/2', char: 'f'
      post '/games/2', char: 'a'

      post '/games', solution: 'test'
      post '/games/3', char: 't'
      post '/games/3', char: 'e'
      post '/games/3', char: 's'

      get '/games'

      expected = {
        "games" => [
          {
            "game" => {
              "id" => 1,
              "word" => "awe...e",
              "status" => "busy",
              "tries_left"=>11
            }
          },
          {
            "game" => {
              "id" => 2,
              "word" => "fa..a....",
              "status" => "busy",
              "tries_left" => 10
            }
          },
          {
            "game" => {
              "id" => 3,
              "word" => "test",
              "status" => "success",
              "tries_left"=>11
            }
          }
        ]
      }

      expect(JSON.parse response.body).to eq expected
    end
  end
end

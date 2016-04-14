require 'spec_helper'
require './app/models/hangman_game'

RSpec.describe HangmanGame do
  let(:solution) { 'awesome' }
  let(:max_tries) { 11 }
  subject { described_class.new(solution: solution, max_tries: max_tries) }

  def guess(characters)
    characters.chars.each { |char| subject.guess char }
  end

  context "with no guesses" do
    it "word is represented by dots" do
      expect(subject.word).to eq '.......'
    end

    it "status is :busy" do
      expect(subject.status).to eq :busy
    end
  end

  context "with some correct guesses" do
    before { guess 'awde' }

    it "shows the found characters" do
      expect(subject.word).to eq 'awe...e'
    end

    it "status is :busy" do
      expect(subject.status).to eq :busy
    end
  end

  context "word has been found within the number of max tries" do
    before { guess 'awdesome' }

    it "shows the solution" do
      expect(subject.word).to eq solution
    end

    it "status is :success" do
      expect(subject.status).to eq :success
    end
  end

  context "word has not been found within the number of max tries" do
    before { guess 'abcdfghijklp' }

    it "shows the found characters" do
      expect(subject.word).to eq 'a......'
    end

    it "status is :fail" do
      expect(subject.status).to eq :fail
    end
  end
end

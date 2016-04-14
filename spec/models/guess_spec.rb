require 'rails_helper'

RSpec.describe Guess do
  let(:character) { 'a' }
  subject { described_class.new character: character }

  it "is valid" do
    expect(subject).to be_valid
  end

  describe "invalid character" do
    %w(A 1 - . te).each do |char|
      let(:character) { char }

      it "is invalid" do
        expect(subject).to be_invalid
      end
    end
  end
end

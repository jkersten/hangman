require 'rails_helper'

RSpec.describe Game do
  let(:solution) { 'awesome' }
  subject { described_class.new solution: solution }

  it "is valid" do
    expect(subject).to be_valid
  end

  describe "invalid solution" do
    %w(A Test a123 dash-ed).each do |word|
      let(:solution) { word }

      it "is invalid" do
        expect(subject).to be_invalid
      end
    end
  end
end

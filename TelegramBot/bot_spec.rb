require_relative 'config.rb'
require 'rspec'

describe do
  context "Функція checkToken" do
    it "повертає true" do
    expect(checkToken(Token)).to eq true
  end
end
end

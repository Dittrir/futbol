require 'csv'
require 'simplecov'
require './lib/game_stats'

SimpleCov.start

RSpec.describe GameStats do
  before :each do
    @game_path = './data/games.csv'
    @rows = CSV.read(@game_path, headers: true)
    @row = @rows[1]
    @game_stats = GameStats.new(@row)
  end
  it 'exists' do

    expect(@game_stats).to be_an_instance_of(GameStats)
  end
end

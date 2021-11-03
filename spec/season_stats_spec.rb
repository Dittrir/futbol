require 'csv'
require 'simplecov'
require './lib/season_stats'

SimpleCov.start

RSpec.describe SeasonStats do
  before :each do
    @season_path = './data/sample_game_teams.csv'

    @season_stats = SeasonStats.new(@season_path)
  end

  it 'exists' do

    expect(@season_stats).to be_an_instance_of(SeasonStats)
  end

  it 'winningest_coach' do

    expect(@season_stats.winningest_coach).to eq("Mike Babcock")
  end

  xit 'worst_coach' do

    expect(@season_stats.worst_coach).to eq("Dan Bylsma")
  end

  xit 'most_accurate_team' do

    expect(@season_stats.most_accurate_team).to eq("17")
  end

  xit 'least_accurate_team' do

    expect(@season_stats.least_accurate_team).to eq("5")
  end

  xit 'most_tackles' do

    expect(@season_stats.most_tackles).to eq("6")
  end

  xit 'fewest_tackles' do

    expect(@season_stats.fewest_tackles).to eq("17")
  end
end

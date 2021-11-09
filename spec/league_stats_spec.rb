require 'csv'
require 'simplecov'
require './lib/league_stats'


SimpleCov.start

RSpec.describe LeagueStats do
  before :each do
    @league_path = './data/sample_game_teams.csv'

    @league_stats = LeagueStats.new(@league_path)
  end

  it 'exists' do

    expect(@league_stats).to be_an_instance_of(LeagueStats)
  end

  it '#count_of_teams' do

    expect(@league_stats.count_of_teams).to eq(5)
  end

  it '#best_offense' do

    expect(@league_stats.best_offense).to eq("LA Galaxy")
  end

  it '#worst_offense' do

    expect(@league_stats.worst_offense).to eq("Sporting Kansas City")
  end

  it '#highest_scoring_visitor' do

    expect(@league_stats.highest_scoring_visitor).to eq("FC Dallas")
  end

  it '#highest_scoring_home_team' do

    expect(@league_stats.highest_scoring_home_team).to eq("LA Galaxy")
  end

  it 'lowest_scoring_visitor' do

    expect(@league_stats.worst_offense).to eq("Sporting Kansas City")
  end

  it 'lowest_scoring_home_team' do

    expect(@league_stats.worst_offense).to eq("Sporting Kansas City")
  end
end

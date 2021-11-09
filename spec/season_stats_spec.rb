require 'csv'
require 'simplecov'
require './lib/season_stats'
require './lib/stat_tracker'

SimpleCov.start

RSpec.describe SeasonStats do
  before :each do
    @game_teams_path = './data/game_teams.csv'
    @game_path = './data/games.csv'
    @team_path = './data/teams.csv'
    # @game_teams_path = CSV.parse(File.read('./data/game_team.csv'), headers: true)
    # @game_data = CSV.parse(File.read('./data/games.csv'), headers: true)
    # @team_data = CSV.parse(File.read('./data/teams.csv'), headers: true)

    @season_stats = SeasonStats.new(@game_teams_path, @game_path, @team_path)
  end

  it 'exists' do

    expect(@season_stats).to be_an_instance_of(SeasonStats)
  end

  it 'winningest_coach' do

    expect(@season_stats.winningest_coach).to eq("Claude Julien")
  end

  it 'worst_coach' do

    expect(@season_stats.worst_coach).to eq("John Tortorella")
  end

  it 'most_accurate_team' do

    expect(@season_stats.most_accurate_team).to eq("3")
  end

  it 'least_accurate_team' do

    expect(@season_stats.least_accurate_team).to eq("16")
  end

  it 'most_tackles' do

    expect(@season_stats.most_tackles).to eq("6")
  end

  it 'fewest_tackles' do

    expect(@season_stats.fewest_tackles).to eq("16")
  end
end

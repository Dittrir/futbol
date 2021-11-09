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
    before(:all) do
      game_path = './data/games.csv'
      team_path = './data/teams.csv'
      game_teams_path = './data/game_teams.csv'

      locations = {
        games: game_path,
        teams: team_path,
        game_teams: game_teams_path
      }

    @stat_tracker = StatTracker.from_csv(locations)
  end

  it "#winningest_coach" do
    expect(@season_stats.winningest_coach("20132014")).to eq "Claude Julien"
    expect(@season_stats.winningest_coach("20142015")).to eq "Alain Vigneault"
  end

  it "#worst_coach" do
    expect(@season_stats.worst_coach("20132014")).to eq "Ted Nolan" # ACTUAL "Peter Laviolette" #
    expect(@season_stats.worst_coach("20142015")).to eq("Craig MacTavish").or(eq("Ted Nolan"))
  end

  it "#most_accurate_team" do
    expect(@season_stats.most_accurate_team("20132014")).to eq "Real Salt Lake"
    expect(@season_stats.most_accurate_team("20142015")).to eq "Toronto FC"
  end

  it "#least_accurate_team" do
    expect(@season_stats.least_accurate_team("20132014")).to eq "New York City FC"
    expect(@season_stats.least_accurate_team("20142015")).to eq "Columbus Crew SC"
  end

  it "#most_tackles" do
    expect(@season_stats.most_tackles("20132014")).to eq "FC Cincinnati"
    expect(@season_stats.most_tackles("20142015")).to eq "Seattle Sounders FC"
  end

  it "#fewest_tackles" do
    expect(@season_stats.fewest_tackles("20132014")).to eq "Atlanta United"
    expect(@season_stats.fewest_tackles("20142015")).to eq "Orlando City SC"
  end
end

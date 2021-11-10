require 'csv'
require 'simplecov'
require './lib/team_stats'

SimpleCov.start

RSpec.describe TeamStats do
  before :each do
    @team_info_path = './data/teams.csv'
    @rows = CSV.read(@team_info_path, headers: true)
    @row = @rows[1]
    @team_stats = TeamStats.new(@row)
  end

  it 'exists' do
    expect(@team_stats).to be_instance_of(TeamStats)
  end
end

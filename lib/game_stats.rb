require 'csv'
require 'simplecov'

SimpleCov.start

class GameStats
  attr_reader :game_id, :season_id, :type, :date_time, :away_team_id, :home_team_id, :away_goals, :home_goals, :venue, :venue_link
  def initialize(game_data)
    @game_id = game_data["game_id"]
    @season_id = game_data["season"]
    @type = game_data["type"]
    @date_time = game_data["date_time"]
    @away_team_id = game_data["away_team_id"]
    @home_team_id = game_data["home_team_id"]
    @away_goals = game_data["away_goals"].to_i
    @home_goals = game_data["home_goals"].to_i
    @venue = game_data["venue"]
    @venue_link = game_data["venue_link"]
  end
end

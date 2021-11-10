require 'csv'
require 'simplecov'
class GameTeams
  attr_reader :game_id,
              :team_id,
              :hoa,
              :result,
              :head_coach,
              :goals,
              :shots,
              :tackles,
              :pim,
              :power_play_opportunities,
              :power_play_goals,
              :face_off_win_percentage,
              :giveaways,
              :takeaways
  def initialize(game_teams_stats)
    @game_id = game_team_stats["game_id"]
    @team_id = game_team_stats["team_id"]
    @hoa = game_team_stats["HoA"]
    @result = game_team_stats["result"]
    @head_coach = game_team_stats["head_coach"]
    @goals = game_team_stats["goals"].to_i
    @shots = game_team_stats["shots"].to_i
    @tackles = game_team_stats["tackles"].to_i
    @pim = game_team_stats["pim"].to_i
    @power_play_opportunities = game_team_stats["powerPlayOpportunities"]
    @power_play_goals = game_team_stats["power_play_goals"]
    @face_off_win_percentage = game_team_stats["face_off_win_percentage"]
    @giveaways = game_team_stats["giveaways"]
    @takeaways = game_teams_stats["takeaways"]
  end
end

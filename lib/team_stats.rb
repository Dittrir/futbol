require 'csv'
require 'simplecov'

SimpleCov.start

class TeamStats
  attr_reader :team_id,
              :franchise_id,
              :team_name,
              :abbreviation,
              :stadium,
              :link

  def initialize(team_data)
    @team_id      = team_data["team_id"]
    @franchise_id = team_data["franchiseId"]
    @team_name    = team_data["teamName"]
    @abbreviation = team_data["abbreviation"]
    @stadium      = team_data["Stadium"]
    @link         = team_data["link"]
  end

  def win_loss_counter
    @season_data.each do |game|
      if game["result"] == "WIN"
        @season_log[game["team_id"]][1] += 1
      else
        @season_log[game["team_id"]][2] += 1
      end
    end
  end
end

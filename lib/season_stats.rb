require 'csv'
require 'simplecov'

SimpleCov.start

class SeasonStats
  attr_reader :season_data
  def initialize(game_teams_path, game_data, team_data)
    @game_teams_path = CSV.parse(File.read('./data/game_team.csv'), headers: true)
    @game_data = CSV.parse(File.read('./data/games.csv'), headers: true)
    @team_data = CSV.parse(File.read('./data/teams.csv'), headers: true)
    @total_games_per_season = 0
  end

  def winningest_coach(season_id) #best win % of season (gameswon/totalgames)
    coach = nil
    team_wins = win_count(season_id)
    winningest_team = team_wins.max_by do |team_id, wins|
      wins
    end
    winningest_coach = @season_data.find_all do |game_team|
      if game_team["team_id"] == winningest_team[0] && game_team["game_id"].slice(0..3) == season_id.slice(0..3)
        coach = game_team["head_coach"]
      else
      end
    end
    coach
  end

  def worst_coach(season_id)
    coach_w = nil
    team_wins = win_count(season_id)
    worst_team = team_wins.min_by do |team_id, wins|
      wins
    end
    worst_coach = @season_data.find_all do |game_team|
      if game_team["team_id"] == worst_team[0] && game_team["game_id"].slice(0..3) == season_id.slice(0..3)
        coach_w = game_team["head_coach"]
      else
      end
    end
    coach_w
  end

  def win_count(season_id)
    team_wins = {}
    @game_data.map do |game|
      if game["season"] == season_id
        if game["away_goals"] > game["home_goals"]
          team_wins[game["away_team_id"]] ||= 1
          team_wins[game["away_team_id"]] += 1
        elsif game["home_goals"] > game["away_goals"]
          team_wins[game["home_team_id"]] ||= 1
          team_wins[game["home_team_id"]] += 1
        end
      end
    end
    team_wins
  end

  def most_accurate_team(season_id)
    team_name = nil
    team_shots_goals_accuracy = shot_goal_counter(season_id)
    most_accurate_team = team_shots_goals_accuracy.max_by do |team_id, wins|
      wins[2]
    end
    @team_data.find_all do |team|
      if team["team_id"] == most_accurate_team[0]
        team_name = team["teamName"]
      else
      end
    end
    team_name
  end

  def least_accurate_team(season_id)
    team_name = nil
    team_shots_goals_accuracy = shot_goal_counter(season_id)
    least_accurate_team = team_shots_goals_accuracy.min_by do |team_id, shot_goal_accuracy|
      shot_goal_accuracy[2]
    end
    @team_data.find_all do |team|
      if team["team_id"] == least_accurate_team[0]
        team_name = team["teamName"]
      else
      end
    end
    team_name
  end

  def shot_goal_counter(season_id) #best ratio of shots to goals for the season
    shot_goals_accuracy = {}
    @season_data.map do |game|
      if game["game_id"].slice(0..3) == season_id.slice(0..3)
        shot_goals_accuracy[game["team_id"]] ||= [0, 0, 0]
        shot_goals_accuracy[game["team_id"]][0] += (game["shots"]).to_i
        shot_goals_accuracy[game["team_id"]][1] += (game["goals"]).to_i
      else
      end
    end
    shot_goals_accuracy.each do |team|
      team[1][2] = (team[1][1].to_f / team[1][0]).round(3) #goals/shots ratio
    end
    shot_goals_accuracy
  end
end

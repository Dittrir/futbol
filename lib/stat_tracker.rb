require 'csv'
require 'simplecov'
require_relative './game_stats'
require_relative './league_stats.rb'
require_relative './season_stats.rb'
require_relative './team_stats.rb'
require_relative './game_team_stats'

SimpleCov.start

class StatTracker
  attr_accessor :game_teams_path,
                :teams_path,
                :games_path,
                :games_path_1,
                :teams_path_1,
                :game_teams_path_1

  def initialize(locations)
    @game_hash = {}
    @team_hash = {}
    @game_teams_hash = {}
    @games_path = games(locations[:games])
    @teams_path = my_teams(locations[:teams])
    @game_teams_path = my_game_teams(locations[:game_teams])
    @games_path_1 = CSV.parse(File.read("./data/games.csv"), headers: true)
    @teams_path_1 = CSV.parse(File.read("./data/teams.csv"), headers: true)
    @game_teams_path_1 = CSV.parse(File.read("./data/game_teams.csv"), headers: true)
  end

  def self.from_csv(locations)
    StatTracker.new(locations)
  end

  def games(game_stats)
    rows = CSV.read(game_stats, headers: true)
    rows.map do |row|
      @game_hash[row['game_id']] = GameStats.new(row)
    end
  end

  def my_teams(team_stats)
    rows = CSV.read(team_stats, headers: true)
    rows.map do |row|
      @team_hash[row['team_id']] = TeamStats.new(row)
    end
  end

  def my_game_teams(game_team_stats)
    rows = CSV.read(game_team_stats, headers: true)
    rows.map do |row|
      @game_teams_hash[row['team_id']] = GameTeamStats.new(row)
    end
  end


  def highest_total_score
    max_score = 0
    @game_hash.each_value do |game|
      sum = game.away_goals + game.home_goals
      if sum > max_score
        max_score = sum
      end
    end
    max_score
  end

  def lowest_total_score
     low_score = 100
     @games_path.each do |game|
       sum = game.away_goals + game.home_goals
       if sum < low_score
         low_score = sum
       end
     end
     low_score
   end

   def percentage_home_wins
    home_wins = 0
    total_game = 0
    @games_path.each do |game|
      total_game += 1
      if game.home_goals > game.away_goals
        home_wins += 1
      else
      end
    end
    x = (home_wins.to_f / total_game.to_f).round(2)
  end

  def percentage_visitor_wins
    away_wins = 0
    total_game = 0
    @games_path.each do |game|
      total_game += 1
      if game.away_goals > game.home_goals
        away_wins += 1
      else
      end
    end
    x = (away_wins.to_f / total_game.to_f).round(2)
  end

  def best_offense
    league_stats = LeagueStats.new(@game_teams_path_1)
    league_stats.best_offense
  end

  def worst_offense
    league_stats = LeagueStats.new(@game_teams_path_1)
    league_stats.worst_offense
  end

  def highest_scoring_visitor
    league_stats = LeagueStats.new(@game_teams_path_1)
    league_stats.highest_scoring_visitor
  end

  def highest_scoring_home_team
    league_stats = LeagueStats.new(@game_teams_path_1)
    league_stats.highest_scoring_home_team
  end

  def lowest_scoring_visitor
    league_stats = LeagueStats.new(@game_teams_path_1)
    league_stats.lowest_scoring_visitor
  end

  def lowest_scoring_home_team
    league_stats = LeagueStats.new(@game_teams_path_1)
    league_stats.lowest_scoring_home_team
  end

  def winningest_coach(season_id)
    season_stats = SeasonStats.new(@game_teams_path_1, @games_path_1, @teams_path_1)
    season_stats.winningest_coach(season_id)
  end

  def worst_coach(season_id)
    season_stats = SeasonStats.new(@game_teams_path_1, @games_path_1, @teams_path_1)
    season_stats.worst_coach(season_id)
  end

  def most_accurate_team(season_id)
    season_stats = SeasonStats.new(@game_teams_path_1, @games_path_1, @teams_path_1)
    season_stats.most_accurate_team(season_id)
  end

  def least_accurate_team(season_id)
    season_stats = SeasonStats.new(@game_teams_path_1, @games_path_1, @teams_path_1)
    season_stats.least_accurate_team(season_id)
  end

  def most_tackles(season_id)
    season_stats = SeasonStats.new(@game_teams_path, @games_path, @teams_path)
    season_stats.most_tackles(season_id)
  end

  def fewest_tackles(season_id)
    season_stats = SeasonStats.new(@game_teams_path, @games_path, @teams_path)
    season_stats.fewest_tackles(season_id)
  end
  
  def percentage_ties
    total_game = 0
    total_ties = 0
    @games_path.each do |game|
      total_game += 1
      if game.home_goals == game.away_goals
        total_ties += 1
      else
      end
    end
    x = (total_ties.to_f / total_game.to_f).round(2)
  end

  def count_of_games_by_season
    tgps = Hash.new(0)
    @games_path.each do |game|
      tgps[game.season_id] += 1
    end
    tgps
  end

  def average_goals_per_game
    total_game = 0.0
    away_goals = 0.0
    home_goals = 0.0
    @games_path.each do |game|
      total_game += 1
      away_goals += (game.away_goals).to_f
      home_goals += (game.home_goals).to_f
    end
    sum = away_goals + home_goals
    avg_goal_per_game = sum / total_game
    avg_goal_per_game.round(2)
  end

  def average_goals_by_season
    avg_goal_by_season = count_of_games_by_season
    avg_goal_by_season.transform_values! do |season_games|
      [season_games, 0]
    end
    @games_path.each do |game|
      avg_goal_by_season[game.season_id][1] += game.home_goals
      avg_goal_by_season[game.season_id][1] += game.away_goals
    end
    avg_goal_by_season.transform_values do |season_games|
      (season_games[1] / season_games[0].to_f).round(2)
    end
  end

  def team_info(team_id)
    team_info = {
      'team_id' => @team_hash[team_id].team_id,
      'franchiseId' => @team_hash[team_id].franchise_id,
      'team_name' => @team_hash[team_id].team_name,
      'abbreviation' => @team_hash[team_id].abbreviation,
      'link' => @team_hash[team_id].link
    }
  end

  def best_season(team_id)
    season = nil
    team_wins_percent = win_percent(team_id)
    # require "pry"; binding.pry
    best_team_season = team_wins_percent.max_by do |season_id, wins_total_percent|
      wins_total_percent[2]
    end
    # winningest_coach = @season_data.find_all do |game_team|
    #   if game_team["team_id"] == winningest_team[0] && game_team["game_id"].slice(0..3) == season_id.slice(0..3)
    #     coach = game_team["head_coach"]
    #   else
    #   end
    # end
    # coach
  end

  def win_percent(team_id) #best ratio of shots to goals for the season
    wins_total_percent = {}
    @game_teams_hash.each do |game|
      # if game["game_id"].slice(0..3) == season_id.slice(0..3)
      # require "pry"; binding.pry
      if game[0] == team_id
        # require "pry"; binding.pry
        wins_total_percent[game[1].game_id.slice(0..3)] ||= [0, 0, 0]
        if game[1].result == "WIN"
        wins_total_percent[game[1].game_id.slice(0..3)][0] += 1
        wins_total_percent[game[1].game_id.slice(0..3)][1] += 1
      elsif game[1].result == "LOSS"
        wins_total_percent[game[1].game_id.slice(0..3)][1] += 1
        else #game["result"] == "TIE"
        wins_total_percent[game[1].game_id.slice(0..3)][1] += 1
        end
      else
      end
    end
    # require "pry"; binding.pry
    wins_total_percent.each do |season|
      season[1][2] = (season[1][1].to_f / season[1][0]).round(3) #goals/shots ratio
    end
    wins_total_percent
  end
end

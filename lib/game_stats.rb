require 'csv'
require 'simplecov'
require './lib/stat_tracker'

SimpleCov.start

class GameStats
  attr_reader :game_data

  def initialize(game_data)
    #@game_data = CSV.read("./data/sample_games.csv")
    @game_data = CSV.parse(File.read("./data/sample_games.csv"), headers: true)
  end

  def highest_total_score
    max_score = 0
    @game_data.each do |game|
      sum = game["away_goals"].to_i + game["home_goals"].to_i
      if sum > max_score
        max_score = sum
      end
    end
    max_score
  end

  def lowest_total_score
    low_score = 100
    @game_data.each do |game|
      sum = game["away_goals"].to_i + game["home_goals"].to_i
      if sum < low_score
        low_score = sum
      end
    end
    low_score
  end

  def percentage_home_wins
    home_wins = 0
    total_game = 0
    @game_data.each do |game|
      total_game += 1
      if game["home_goals"] > game["away_goals"]
        home_wins += 1
      else
      end
    end
    x = (home_wins.to_f / total_game.to_f)
    (x * 100.0).round(2)
  end

  def percentage_away_wins
    away_wins = 0
    total_game = 0
    @game_data.each do |game|
      total_game += 1
      if game["away_goals"] > game["home_goals"]
        away_wins += 1
      else
      end
    end
    x = (away_wins.to_f / total_game.to_f)
    (x * 100.0).round(2)
  end

  def percentage_ties
    total_game = 0
    total_ties = 0
    @game_data.each do |game|
      total_game += 1
      if game["home_goals"] == game["away_goals"]
        total_ties += 1
      else
      end
    end
    x = (total_ties.to_f / total_game.to_f)
    (x * 100.0).round(2)
  end

  def count_of_games_by_season
    total_games_per_season = Hash.new(0)
    @game_data["season"].each do |game|
      total_games_per_season[game] += 1
    end
    total_games_per_season
    # total_games_per_season.each do |k, v|
  end

  def average_goals_per_game
    total_game = 0.0
    away_goals = 0.0
    home_goals = 0.0
    @game_data.each do |game|
      total_game += 1
      away_goals += (game["away_goals"]).to_f
      home_goals += (game["home_goals"]).to_f
    end
    sum = away_goals + home_goals
    avg_goal_per_game = sum / total_game
    avg_goal_per_game.round(2)
  end

  def average_goals_per_season
    avps = @game_data.group_by do |season|
      count_of_games_by_season.keys.each do |sea|
        require "pry"; binding.pry
      # season["season"]
      # if season.values_at("season")[0] == sea
      # total = season.values_at("away_goals")[0].to_f + season.values_at("home_goals")[0].to_f
    end
    end
    # sum = 0
    # avps.each do |avp|
    #   avp[1].each do |a|
    # # require "pry"; binding.pry

  end
end

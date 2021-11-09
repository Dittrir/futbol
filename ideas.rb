require 'csv'
require 'simplecov'
require './lib/stat_tracker'

SimpleCov.start

class GameStats
  attr_reader :game_data
  def initialize(game_data)
    @game_data = CSV.parse(File.read("./data/sample_games.csv"), headers: true)
    @seasons = []
  end

  def game_log_method

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
  end

  # def total_goals_per_season
  #   tgps = Hash.new(0)
  #
  #   @game_data.each do |game|
  #     count_of_games_by_season.each do |sea|
  #       if sea.first == sea[0]
  #       tgps[sea] ||= []
  #       tgps[season] << (game["away_goals"].to_f)
  #       end
  #     end
  #   end
  #   require "pry"; binding.pry
  #   # tgps[game] << (game["home_goals"].to_f)
  #   tgps
  # end

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
    avg = {}
    count_of_games_by_season.each_pair do |season, games|
      avg[season] = (total_goals(season) / games).round(2)
    end
    avg
  end

  def season_games
    @game_data.group_by do |game|
      game["season"]
    end
  end

  def total_goals(season)
    (total_away_goals(season) + total_home_goals(season)).sum
  end

  def total_away_goals(season)
    away = @game_data["away_goals"].select do |goal|
      @game_data["season"].include?(season)
    end
    require "pry"; binding.pry
    away.map do |goal|
      goal.to_f
    end
  end

  def total_home_goals(season)
    home = @game_data["home_goals"].select do |goal|
      @game_data["season"].include?(season)
    end
    home.map do |goal|
      goal.to_f
    end
  end
end

  # def count_of_goals_by_season
  #   total = 0
  #   total_goals_per_season = Hash.new(0)
  #   @game_data["season"].each do |game|
  #     require "pry"; binding.pry
  #     total_games_per_season[game] += @game_data["away_goals"].
  #   end
  #   total_goals_per_season
  # end

  # def total_goals_per_season
  #   tgps = []
  #   total = 0
  #   @game_data.group_by do |season|
  #     count_of_games_by_season.map do |sea|
  #       if season.values_at("season")[0] == sea[0]
  #         total = (season.values_at("away_goals")[0].to_f += season.values_at("home_goals")[0].to_f)
  #       else
  #       end
  #     end
  #     require "pry"; binding.pry
  #   end
  # end
#
  # def average_goals_per_season
  #   avg = 0.0
  #   total = 0.0
  #   avg_hash = Hash.new(0)
  #   avps = @game_data.group_by do |season|
  #     count_of_games_by_season.each do |sea|
  #       if season.values_at("season")[0] == sea[0]
  #         total = (season.values_at("away_goals")[0].to_f + season.values_at("home_goals")[0].to_f)
  #       end
  #       avg = (total / sea.last.to_f).round(2)
  #       avg_hash[sea.first] = avg
  #     end
  #   end
  #   bi
  #   avg_hash
  # end

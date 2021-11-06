require 'csv'
require 'simplecov'
require './lib/stat_tracker'

SimpleCov.start

class GameStats
  attr_reader :game_data,
              :game_data1

  def initialize(game_data)
    #@game_data = CSV.read("./data/sample_games.csv")
    @game_data = CSV.parse(File.read("./data/sample_games.csv"), headers: true)
    @game_data1 = CSV.read(File.read("./data/sample_games.csv"), headers: true)
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

  # def total_goals
  #   x = []
  #   @game_data.each do |game|
  #     x << game
  #   end
  #     require "pry"; binding.pry
  #   sum = x[8].values_at[6].to_f + x[8].values_at[7].to_f
  # end

  def average_goals_per_season
    total = 0
    avg = 0
    avg_hash = Hash.new(0)
    avps = @game_data.group_by do |season|
      count_of_games_by_season.keys.each do |sea|
        if season["season"] == sea
          require "pry"; binding.pry
        total = season.values_at("away_goals")[0].to_f + season.values_at("home_goals")[0].to_f
        end
      end
    end
  end

  # def average_goals_per_season
  #   total = 0.0
  #   avg = 0.0
  #   x = nil
  #   avg_hash = Hash.new(0)
  #   avps = @game_data.group_by do |season|
  #     count_of_games_by_season.each do |sea|
  #       if season.values_at("season")[0] == sea[0]
  #         require "pry"; binding.pry
  #         x = (season.values_at("away_goals")[0].to_f + season.values_at("home_goals")[0].to_f)
  #         #require "pry"; binding.pry
  #       else
  #       end
  #       total = x
  #       avg = (total.to_f / sea.last.to_f).round(2)
  #       #require "pry"; binding.pry
  #       avg_hash[sea[0]] = avg
  #     end
  #   end
  #   avg_hash
  # end

  # def
  #   total_goals_per_season = Hash.new(0)
  #   @game_data["away_goals"].each do |ag|
  #     ag.values_at(away_goals)
  #     total_games_per_season[game] += 1
  #   end
  #   total_games_per_season
  # end
end


# season["season"]
# sum = 0
# avps.each do |avp|
#   avp[1].each do |a|
# # require "pry"; binding.pry


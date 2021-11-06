require 'csv'
require 'simplecov'
require_relative './game_stats'
require_relative './league_stats.rb'
require_relative './season_stats.rb'
require_relative './team_stats.rb'

SimpleCov.start

class StatTracker
  attr_reader :game_teams,
              :teams,
              :games

  def initialize(locations)
    @game_teams_path = locations[:game_teams]
    @team_path = locations[:teams]
    @game_path = locations[:games]
  end

  def self.from_csv(locations)
    location_info = {}
    # location_info[:game_teams] = create_new(locations[:game_teams], GameTeamStats)
    location_info[:team] = create_new(locations[:teams], TeamStats)
    # locations_info[:game] = create_new(locations[:game]), GameStats)
    StatTracker.new(location_info)
  end

  def self.create_new(locations, rows)
    new_rows_array = []
    CSV.foreach(locations, headers: true, header_converters: :symbol) do |row|
      # new_row.map do |row|
      new_row = rows.new(row)
      new_rows_array << new_row
        require "pry"; binding.pry
        # GameStats.new(row)
    end
    new_rows_array
  end


  # def highest_total_score
  # end
  #
  # def count_of_teams
  #   league_stats = LeagueStats.new(@game_teams_path)
  #   league_stats.count_of_teams
  # end
  #
  # def best_offense
  #   league_stats = LeagueStats.new(@game_teams_path)
  #   team_id = league_stats.best_offense #<<<<< Need to refactor this, unless I get the exact answer
  # end
end

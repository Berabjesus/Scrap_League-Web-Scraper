# frozen_string_literal: true

require 'json'
class FileHandler
  TEAM_DIR = './docs/clubs/'
  PLAYERS_DIR = './docs/players/'
  def initialize(hash, file_name)
    @hash = hash
    @file_name = file_name
  end

  def teams_to_json
    dir_maker(TEAM_DIR)
    File.write("#{TEAM_DIR}#{@file_name}.json", JSON.dump(@hash))
  end

  def players_to_json
    dir_maker(PLAYERS_DIR)
    players_file_name = "#{@file_name}.json"

    if File.file?("#{PLAYERS_DIR}#{players_file_name}") && File.read("#{PLAYERS_DIR}#{players_file_name}") != ''
      file = JSON.parse(File.read("#{PLAYERS_DIR}#{players_file_name}"))
      file.merge!(@hash)
      File.write("#{PLAYERS_DIR}#{players_file_name}", JSON.dump(file))
    else
      File.write("#{PLAYERS_DIR}#{players_file_name}", JSON.dump(@hash))
    end
  end

  def dir_maker(dir)
    Dir.mkdir(dir) unless File.exist?(dir)
  end

  def self.file_reader(dir_type, file_name)
    return JSON.parse(File.read("#{TEAM_DIR}#{file_name}.json")) if dir_type == 'CLUBS'
    return JSON.parse(File.read(file_name)) if dir_type == 'PLAYERS'
  end

  def self.access_all_players_files
    Dir["#{PLAYERS_DIR}**/*.json"]
  end

end
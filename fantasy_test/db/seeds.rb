require 'open-uri'

unparsed_teams = open("http://www.fantasyfootballnerd.com/service/nfl-teams/json/u6jngrx3y9j9").read
teams = JSON.parse(unparsed_teams)

teams["NFLTeams"].each do |team|
  Team.create!(code: team["code"], full_name: team["fullName"])
end

unparsed_players = open("http://www.fantasyfootballnerd.com/service/players/json/u6jngrx3y9j9").read
players = JSON.parse(unparsed_players)

players["Players"].each do |player|
  Player.create!(player_id: player["playerId"].to_i,
                 active: player["active"].to_i,
                 jersey: player["jersey"].to_i,
                 lname: player["lname"],
                 fname: player["fname"],
                 team: player["team"],
                 position: player["position"],
                 dob: player["dob"],
                 height: player["height"],
                 weight: player["weight"])
end

POSITIONS = ["QB", "RB", "TE", "WR", "K"]

(1..2).each do |i|
  POSITIONS.each do |pos|
    unparsed_week = open("http://www.fantasyfootballnerd.com/service/weekly-rankings/json/u6jngrx3y9j9/#{pos}/#{i}").read
    week = JSON.parse(unparsed_week)
    cur_week = Week.create!(position: week["Position"], week_num: week["Week"].to_i)

    week["Rankings"].each do |ranking|
      Ranking.create!(week_id: cur_week.id, player_id: ranking["playerId"].to_i, points: ranking["standard"].to_f)
    end
  end
end

league = League.create!(name: "Some League")

str = "abcdefghijk"
10.times do |i|
  User.create!(username: Faker::Internet.user_name, password: "042793jc")
  str = str[0..-2]
end

8.times do |i|
  UserMembership.create!(user_id: i + 1, league_id: 1)
end

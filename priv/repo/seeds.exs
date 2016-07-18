# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     KnockoutApi.Repo.insert!(%SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias KnockoutApi.{Repo, Tournament, Match, MatchGroup, Team}

tournament = Repo.insert!(%Tournament{ name: "The International", game_id: "dota-2" })
team_one = Repo.insert!(%Team{ name: "MYM" })
team_two = Repo.insert!(%Team{ name: "Na`Vi" })

match_group = Repo.insert!(%MatchGroup{
  tournament_id: tournament.id,
  team_one_id: team_one.id,
  team_two_id: team_two.id,
  best_of: 3
})

Repo.insert!(%Match{
  winner_id: team_one.id,
  number: 1,
  match_group_id: match_group.id
})

Repo.insert!(%Match{
  winner_id: team_two.id,
  number: 2,
  match_group_id: match_group.id
})

Repo.insert!(%Match{
  winner_id: team_one.id,
  number: 3,
  match_group_id: match_group.id
})

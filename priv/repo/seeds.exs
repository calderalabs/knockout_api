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
use Timex

tournament = Repo.insert!(%Tournament{ name: "Beyond The Summit Overwatch Cup #1", game_id: "overwatch" })
envyus = Repo.insert!(%Team{ full_name: "EnVyUs", short_name: "EnVy", logo_url: "http://www.gosugamers.net/uploads/images/teams/13896-1461450854.jpeg" })
one_shot = Repo.insert!(%Team{ full_name: "1SHOT", short_name: "1SHOT", logo_url: "http://www.gosugamers.net/uploads/images/teams/14955-1458752167.jpeg" })
ng_red = Repo.insert!(%Team{ full_name: "Northern Gaming Red", short_name: "NG Red", logo_url: "http://www.gosugamers.net/uploads/images/teams/15093-1465630747.jpeg" })
liquid = Repo.insert!(%Team{ full_name: "Team Liquid.OW", short_name: "Liquid.OW", logo_url: "http://www.gosugamers.net/uploads/images/teams/14847-1460218327.jpeg" })
cloud9 = Repo.insert!(%Team{ full_name: "Cloud9", short_name: "Cloud9", logo_url: "http://www.gosugamers.net/uploads/images/teams/13994-1457569720.jpeg" })
code7 = Repo.insert!(%Team{ full_name: "Team SoloMid OW", short_name: "Code7", logo_url: "http://www.gosugamers.net/uploads/images/teams/14569-1469217556.jpeg" })
luminosity = Repo.insert!(%Team{ full_name: "Luminosity", short_name: "LG", logo_url: "http://www.gosugamers.net/uploads/images/teams/14586-1458920393.jpeg" })
splyce = Repo.insert!(%Team{ full_name: "Splyce Gaming OW", short_name: "SPLYCEow", logo_url: "http://www.gosugamers.net/uploads/images/teams/15104-1465862025.jpeg" })

# Upper bracket
# 1

match_group = Repo.insert!(%MatchGroup{
  tournament_id: tournament.id,
  team_one_id: envyus.id,
  team_two_id: one_shot.id,
  best_of: 3,
  started_at: Timex.to_datetime({{2016, 7, 09}, {22, 00, 00}}, "Europe/Paris")
})

Repo.insert!(%Match{
  winner_id: envyus.id,
  number: 1,
  match_group_id: match_group.id,
  likes_count: 0,
  vod: %{
    url: "https://www.youtube.com/embed/iZH3HaaqZlU",
    type: "youtube"
  }
})

Repo.insert!(%Match{
  winner_id: envyus.id,
  number: 2,
  match_group_id: match_group.id,
  likes_count: 0,
  vod: %{
    url: "https://www.youtube.com/embed/8MPs5z6LXIg",
    type: "youtube"
  }
})

# 2

match_group = Repo.insert!(%MatchGroup{
  tournament_id: tournament.id,
  team_one_id: ng_red.id,
  team_two_id: liquid.id,
  best_of: 3,
  started_at: Timex.to_datetime({{2016, 7, 09}, {21, 00, 00}}, "Europe/Paris")
})

Repo.insert!(%Match{
  winner_id: ng_red.id,
  number: 1,
  match_group_id: match_group.id,
  likes_count: 0,
  vod: %{
    url: "https://www.youtube.com/embed/3DRTcTCZlSQ",
    type: "youtube"
  }
})

Repo.insert!(%Match{
  winner_id: liquid.id,
  number: 2,
  match_group_id: match_group.id,
  likes_count: 0,
  vod: %{
    url: "https://www.youtube.com/embed/ccSC4sGa6m8",
    type: "youtube"
  }
})

Repo.insert!(%Match{
  winner_id: ng_red.id,
  number: 3,
  match_group_id: match_group.id,
  likes_count: 0,
  vod: %{
    url: "https://www.youtube.com/embed/qk7ZRX0fMyg",
    type: "youtube"
  }
})

# 3

match_group = Repo.insert!(%MatchGroup{
  tournament_id: tournament.id,
  team_one_id: cloud9.id,
  team_two_id: code7.id,
  best_of: 3,
  started_at: Timex.to_datetime({{2016, 7, 09}, {23, 00, 00}}, "Europe/Paris")
})

Repo.insert!(%Match{
  winner_id: code7.id,
  number: 1,
  match_group_id: match_group.id,
  likes_count: 0,
  vod: %{
    url: "https://www.youtube.com/embed/6SIT8IcIFB8",
    type: "youtube"
  }
})

Repo.insert!(%Match{
  winner_id: cloud9.id,
  number: 2,
  match_group_id: match_group.id,
  likes_count: 0,
  vod: %{
    url: "https://www.youtube.com/embed/DvWvDmJ7Zkc",
    type: "youtube"
  }
})

Repo.insert!(%Match{
  winner_id: cloud9.id,
  number: 3,
  match_group_id: match_group.id,
  likes_count: 0,
  vod: %{
    url: "https://www.youtube.com/embed/G5zp1KHR9nU",
    type: "youtube"
  }
})

# 4

match_group = Repo.insert!(%MatchGroup{
  tournament_id: tournament.id,
  team_one_id: envyus.id,
  team_two_id: ng_red.id,
  best_of: 3,
  started_at: Timex.to_datetime({{2016, 7, 10}, {03, 00, 00}}, "Europe/Paris")
})

Repo.insert!(%Match{
  winner_id: envyus.id,
  number: 1,
  match_group_id: match_group.id,
  likes_count: 0,
  vod: %{
    url: "https://www.youtube.com/embed/RqMfquZmBvI",
    type: "youtube"
  }
})

Repo.insert!(%Match{
  winner_id: envyus.id,
  number: 2,
  match_group_id: match_group.id,
  likes_count: 0,
  vod: %{
    url: "https://www.youtube.com/watch?time_continue=1350&v=RqMfquZmBvI",
    type: "youtube"
  }
})

# 5

match_group = Repo.insert!(%MatchGroup{
  tournament_id: tournament.id,
  team_one_id: luminosity.id,
  team_two_id: cloud9.id,
  best_of: 3,
  started_at: Timex.to_datetime({{2016, 7, 10}, {02, 00, 00}}, "Europe/Paris")
})

Repo.insert!(%Match{
  winner_id: cloud9.id,
  number: 1,
  match_group_id: match_group.id,
  likes_count: 0,
  vod: %{
    url: "https://www.youtube.com/embed/NTREzkbnA5w",
    type: "youtube"
  }
})

Repo.insert!(%Match{
  winner_id: cloud9.id,
  number: 2,
  match_group_id: match_group.id,
  likes_count: 0,
  vod: %{
    url: "https://www.youtube.com/watch?time_continue=1500&v=NTREzkbnA5w",
    type: "youtube"
  }
})

# 6

match_group = Repo.insert!(%MatchGroup{
  tournament_id: tournament.id,
  team_one_id: envyus.id,
  team_two_id: cloud9.id,
  best_of: 5,
  started_at: Timex.to_datetime({{2016, 7, 10}, {23, 00, 00}}, "Europe/Paris")
})

Repo.insert!(%Match{
  winner_id: envyus.id,
  number: 1,
  match_group_id: match_group.id,
  likes_count: 0,
  vod: %{
    url: "https://www.youtube.com/embed/JoI8Q20yTfs",
    type: "youtube"
  }
})

Repo.insert!(%Match{
  winner_id: envyus.id,
  number: 2,
  match_group_id: match_group.id,
  likes_count: 0,
  vod: %{
    url: "https://www.youtube.com/watch?time_continue=1320&v=JoI8Q20yTfs",
    type: "youtube"
  }
})

Repo.insert!(%Match{
  winner_id: envyus.id,
  number: 3,
  match_group_id: match_group.id,
  likes_count: 0,
  vod: %{
    url: "https://www.youtube.com/watch?time_continue=2140&v=JoI8Q20yTfs",
    type: "youtube"
  }
})

# Lower bracket
# 1

match_group = Repo.insert!(%MatchGroup{
  tournament_id: tournament.id,
  team_one_id: one_shot.id,
  team_two_id: liquid.id,
  best_of: 3,
  started_at: Timex.to_datetime({{2016, 7, 10}, {00, 00, 00}}, "Europe/Paris")
})

Repo.insert!(%Match{
  winner_id: liquid.id,
  number: 1,
  match_group_id: match_group.id,
  likes_count: 0,
  vod: %{
    url: "https://www.youtube.com/embed/onYcTjHOuBA",
    type: "youtube"
  }
})

Repo.insert!(%Match{
  winner_id: liquid.id,
  number: 2,
  match_group_id: match_group.id,
  likes_count: 0,
  vod: %{
    url: "https://www.youtube.com/embed/p92PblKZsjQ",
    type: "youtube"
  }
})

# 2

match_group = Repo.insert!(%MatchGroup{
  tournament_id: tournament.id,
  team_one_id: splyce.id,
  team_two_id: code7.id,
  best_of: 3,
  started_at: Timex.to_datetime({{2016, 7, 10}, {01, 00, 00}}, "Europe/Paris")
})

Repo.insert!(%Match{
  winner_id: code7.id,
  number: 1,
  match_group_id: match_group.id,
  likes_count: 0,
  vod: %{
    url: "https://www.youtube.com/embed/vcRvlKxWA7s",
    type: "youtube"
  }
})

Repo.insert!(%Match{
  winner_id: code7.id,
  number: 2,
  match_group_id: match_group.id,
  likes_count: 0,
  vod: %{
    url: "https://www.youtube.com/embed/qnLipA1-T74",
    type: "youtube"
  }
})

# 3

match_group = Repo.insert!(%MatchGroup{
  tournament_id: tournament.id,
  team_one_id: luminosity.id,
  team_two_id: liquid.id,
  best_of: 3,
  started_at: Timex.to_datetime({{2016, 7, 10}, {21, 00, 00}}, "Europe/Paris")
})

Repo.insert!(%Match{
  winner_id: luminosity.id,
  number: 1,
  match_group_id: match_group.id,
  likes_count: 0,
  vod: %{
    url: "https://www.youtube.com/embed/oUUvOghwwcs",
    type: "youtube"
  }
})

Repo.insert!(%Match{
  winner_id: luminosity.id,
  number: 2,
  match_group_id: match_group.id,
  likes_count: 0,
  vod: %{
    url: "https://www.youtube.com/watch?time_continue=1440&v=oUUvOghwwcs",
    type: "youtube"
  }
})

# 4

match_group = Repo.insert!(%MatchGroup{
  tournament_id: tournament.id,
  team_one_id: ng_red.id,
  team_two_id: code7.id,
  best_of: 3,
  started_at: Timex.to_datetime({{2016, 7, 10}, {22, 00, 00}}, "Europe/Paris")
})

Repo.insert!(%Match{
  winner_id: code7.id,
  number: 1,
  match_group_id: match_group.id,
  likes_count: 0,
  vod: %{
    url: "https://www.youtube.com/embed/wAmJ_xndnF4",
    type: "youtube"
  }
})

Repo.insert!(%Match{
  winner_id: ng_red.id,
  number: 2,
  match_group_id: match_group.id,
  likes_count: 0,
  vod: %{
    url: "https://www.youtube.com/watch?time_continue=1020&v=wAmJ_xndnF4",
    type: "youtube"
  }
})

Repo.insert!(%Match{
  winner_id: code7.id,
  number: 3,
  match_group_id: match_group.id,
  likes_count: 0,
  vod: %{
    url: "https://www.youtube.com/watch?time_continue=2320&v=wAmJ_xndnF4",
    type: "youtube"
  }
})

# 5

match_group = Repo.insert!(%MatchGroup{
  tournament_id: tournament.id,
  team_one_id: luminosity.id,
  team_two_id: code7.id,
  best_of: 3,
  started_at: Timex.to_datetime({{2016, 7, 11}, {00, 00, 00}}, "Europe/Paris")
})

Repo.insert!(%Match{
  winner_id: code7.id,
  number: 1,
  match_group_id: match_group.id,
  likes_count: 0,
  vod: %{
    url: "https://www.youtube.com/embed/QwYguAxiA44",
    type: "youtube"
  }
})

Repo.insert!(%Match{
  winner_id: code7.id,
  number: 2,
  match_group_id: match_group.id,
  likes_count: 0,
  vod: %{
    url: "https://www.youtube.com/watch?time_continue=1140&v=QwYguAxiA44",
    type: "youtube"
  }
})

# 6

match_group = Repo.insert!(%MatchGroup{
  tournament_id: tournament.id,
  team_one_id: cloud9.id,
  team_two_id: code7.id,
  best_of: 3,
  started_at: Timex.to_datetime({{2016, 7, 11}, {01, 00, 00}}, "Europe/Paris")
})

Repo.insert!(%Match{
  winner_id: code7.id,
  number: 1,
  match_group_id: match_group.id,
  likes_count: 0,
  vod: %{
    url: "https://www.youtube.com/embed/wcsP-GUjXqI",
    type: "youtube"
  }
})

Repo.insert!(%Match{
  winner_id: code7.id,
  number: 2,
  match_group_id: match_group.id,
  likes_count: 0,
  vod: %{
    url: "https://www.youtube.com/watch?time_continue=1620&v=wcsP-GUjXqI",
    type: "youtube"
  }
})

Repo.insert!(%Match{
  winner_id: cloud9.id,
  number: 3,
  match_group_id: match_group.id,
  likes_count: 0,
  vod: %{
    url: "https://www.youtube.com/watch?time_continue=2760&v=wcsP-GUjXqI",
    type: "youtube"
  }
})

Repo.insert!(%Match{
  winner_id: code7.id,
  number: 4,
  match_group_id: match_group.id,
  likes_count: 0,
  vod: %{
    url: "https://www.youtube.com/watch?time_continue=4320&v=wcsP-GUjXqI",
    type: "youtube"
  }
})

defmodule KnockoutApi.MatchGroupsController do
  alias KnockoutApi.{Repo, User, MatchGroup, Team}
  use KnockoutApi.Web, :controller
  import Ecto.Query
  import KnockoutApi.BaseController

  def index(conn, %{ "tournament_id" => tournament_id }) do
    current_user = current_user(conn)
    match_groups = Repo.all(from m in MatchGroup, where: m.tournament_id == ^(tournament_id))
    team_one_ids = match_groups |> Enum.map(fn(m) -> m.team_one_id end) |> Enum.uniq
    team_two_ids = match_groups |> Enum.map(fn(m) -> m.team_two_id end) |> Enum.uniq
    teams = Repo.all(from t in Team, where: t.id in ^(team_one_ids) or t.id in ^(team_two_ids))
    matches = Repo.all(Ecto.assoc(match_groups, :matches))
    match_groups_spoilers = User.filter_query_by_user(Ecto.assoc(match_groups, :spoilers), current_user)
    matches_spoilers = User.filter_query_by_user(Ecto.assoc(matches, :spoilers), current_user)
    watchings = User.filter_query_by_user(Ecto.assoc(matches, :watchings), current_user)
    likes = User.filter_query_by_user(Ecto.assoc(matches, :likes), current_user)

    render conn, data: match_groups, opts: %{
      match_groups: match_groups,
      teams: teams,
      matches: matches,
      match_groups_spoilers: match_groups_spoilers,
      matches_spoilers: matches_spoilers,
      watchings: watchings,
      likes: likes
    }
  end
end

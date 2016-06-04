defmodule KnockoutApi.TheScore.Importer do
  def import_matches(game) do
    matches = KnockoutApi.TheScore.Server.fetch_matches(game)

    matches["tournaments"]
    |> Enum.each(fn (params) ->
      changeset = KnockoutApi.Tournament.changeset(%KnockoutApi.Tournament{}, params)

      case KnockoutApi.Repo.insert(changeset) do
        {:ok, tournament} ->
          IO.puts("Imported #{tournament.name}")
        {:error, changeset} ->
          IO.puts("There was an error importing #{params["name"]}")
          Enum.each(changeset.errors, fn (error) -> IO.inspect(error) end)
      end
    end)

    matches["teams"]
    |> Enum.each(fn (params) ->
      changeset = KnockoutApi.Team.changeset(%KnockoutApi.Team{}, params)

      case KnockoutApi.Repo.insert(changeset) do
        {:ok, team} ->
          IO.puts("Imported #{team.full_name}")
        {:error, changeset} ->
          IO.puts("There was an error importing #{params["full_name"]}")
          Enum.each(changeset.errors, fn (error) -> IO.inspect(error) end)
      end
    end)

    matches["match_groups"]
    |> Enum.each(fn (params) ->
      winner = if params["winner_id"] do
        KnockoutApi.Repo.get_by(KnockoutApi.Team, the_score_id: params["winner_id"])
      else
        %{id: nil}
      end

      new_params = Dict.merge(params, %{
        "team_one_id" => KnockoutApi.Repo.get_by!(KnockoutApi.Team, the_score_id: params["team_one_id"]).id,
        "team_two_id" => KnockoutApi.Repo.get_by!(KnockoutApi.Team, the_score_id: params["team_two_id"]).id,
        "tournament_id" => KnockoutApi.Repo.get_by!(KnockoutApi.Tournament, the_score_id: params["tournament_id"]).id,
        "winner_id" => winner.id
      })

      changeset = KnockoutApi.MatchGroup.changeset(%KnockoutApi.MatchGroup{}, new_params)

      case KnockoutApi.Repo.insert(changeset) do
        {:ok, match_group} ->
          IO.puts("Imported #{match_group.the_score_id}")
        {:error, changeset} ->
          IO.puts("There was an error importing #{new_params["the_score_id"]}")
          Enum.each(changeset.errors, fn (error) -> IO.inspect(error) end)
      end
    end)

    matches["matches"]
    |> Enum.each(fn (params) ->
      winner = if params["winner_id"] do
        case KnockoutApi.Repo.get_by(KnockoutApi.Team, the_score_id: params["winner_id"]) do
          nil ->
            %{id: nil}
          winner -> winner
        end
      else
        %{id: nil}
      end

      match_group = case KnockoutApi.Repo.get_by(KnockoutApi.MatchGroup, the_score_id: params["match_group_id"]) do
        nil ->
          %{id: nil}
        match_group -> match_group
      end

      IO.inspect(params)

      new_params = Dict.merge(params, %{
        "match_group_id" => match_group.id,
        "winner_id" => winner.id
      })

      changeset = KnockoutApi.Match.changeset(%KnockoutApi.Match{}, new_params)

      case KnockoutApi.Repo.insert(changeset) do
        {:ok, match} ->
          IO.puts("Imported #{match.the_score_id}")
        {:error, changeset} ->
          IO.puts("There was an error importing #{new_params["the_score_id"]}")
          Enum.each(changeset.errors, fn (error) -> IO.inspect(error) end)
      end
    end)
  end
end

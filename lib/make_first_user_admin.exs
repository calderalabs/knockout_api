KnockoutApi.User |> Ecto.Query.first |> KnockoutApi.Repo.one |> KnockoutApi.User.changeset(%{ admin: true }) |> KnockoutApi.Repo.update

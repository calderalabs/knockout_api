defmodule KnockoutApi.TournamentTest do
  use KnockoutApi.ModelCase

  alias KnockoutApi.Tournament

  @valid_attrs %{name: "some content", game_id: 1}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Tournament.changeset(%Tournament{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Tournament.changeset(%Tournament{}, @invalid_attrs)
    refute changeset.valid?
  end
end

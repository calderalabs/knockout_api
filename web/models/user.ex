defmodule KnockoutApi.User do
  use KnockoutApi.Web, :model
  import Joken

  schema "users" do
    field :name, :string

    timestamps
  end

  @required_fields ~w(name)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end

  def verify_token(jwt) do
    jwt
    |> token
    |> with_signer(hs256(Base.url_decode64!(System.get_env("AUTH0_CLIENT_SECRET"))))
    |> verify
  end
end

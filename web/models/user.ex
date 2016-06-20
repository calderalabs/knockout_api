defmodule KnockoutApi.User do
  alias KnockoutApi.Repo
  use KnockoutApi.Web, :model
  import Joken

  schema "users" do
    field :name, :string
    field :auth0_id, :string
    field :email, :string

    timestamps
  end

  @required_fields ~w(name email auth0_id)
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

  def find_or_create(token, credentials) do
    case Repo.get_by(KnockoutApi.User, auth0_id: credentials["sub"]) do
      nil -> create_from_auth0_credentials(token, credentials)
      user -> user
    end
  end

  defp create_from_auth0_credentials(token, credentials) do
    %HTTPoison.Response{body: body} = HTTPoison.post!(
      "#{credentials["iss"]}tokeninfo",
      Poison.encode!(%{ id_token: token }),
      [{"Content-Type", "application/json"}]
    )

    data = Poison.decode!(body)

    KnockoutApi.Repo.insert!(%KnockoutApi.User{
      name: data["name"],
      email: data["email"],
      auth0_id: data["user_id"]
    })
  end
end

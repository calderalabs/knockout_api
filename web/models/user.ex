defmodule KnockoutApi.User do
  alias KnockoutApi.Repo
  use KnockoutApi.Web, :model
  import Joken

  schema "users" do
    has_many :followings, KnockoutApi.Following
    field :name, :string
    field :auth0_id, :string
    field :email, :string
    field :admin, :boolean

    timestamps
  end

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ %{}) do
    model
    |> cast(params, ~w(name email auth0_id admin)a)
    |> validate_required(~w(name email auth0_id)a)
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

  def filter_query_by_user(query, user) do
    case user do
      nil -> []
      user -> Repo.all(from r in query, where: r.user_id == ^(user.id))
    end
  end
end

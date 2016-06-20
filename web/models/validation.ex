defmodule KnockoutApi.Validation do
  def validate(params = {conn, token}) do
    KnockoutApi.User.verify_token(token)
    |> handle(conn)
  end

  defp handle(%{error: nil, claims: claims}, conn) do
    {:ok, claims, conn}
  end

  defp handle(%{error: error}, conn) do
    {:error, [], conn}
  end
end

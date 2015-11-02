defmodule KnockoutApi.Router do
  use KnockoutApi.Web, :router

  pipeline :api do
    plug :accepts, ["json-api"]
    plug JaSerializer.ContentTypeNegotiation
  end

  scope "/", KnockoutApi do
    pipe_through :api

    get "/tournaments", TournamentsController, :index
  end
end

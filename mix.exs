defmodule KnockoutApi.Mixfile do
  use Mix.Project

  def project do
    [app: :knockout_api,
     version: "0.0.1",
     elixir: "~> 1.0",
     elixirc_paths: elixirc_paths(Mix.env),
     compilers: [:phoenix] ++ Mix.compilers,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     aliases: aliases,
     deps: deps]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [mod: {KnockoutApi, []},
     applications: [:phoenix, :phoenix_html, :cowboy, :logger,
                    :phoenix_ecto, :postgrex, :httpoison, :tzdata]]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "web", "test/support"]
  defp elixirc_paths(_),     do: ["lib", "web"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:phoenix, "~> 1.1.6"},
      {:phoenix_ecto, "~> 2.0.2"},
      {:postgrex, ">= 0.11.1"},
      {:phoenix_html, "~> 2.3"},
      {:phoenix_live_reload, "~> 1.0", only: :dev},
      {:cowboy, "~> 1.0"},
      {:ja_serializer, "~> 0.9.0"},
      {:httpoison, "~> 0.8.0"},
      {:exvcr, "~> 0.7", only: :test},
      {:mock, "~> 0.1.1", only: :test},
      {:timex, "~> 3.0.4"},
      {:tzdata, "~> 0.5.7"},
      {:exredis, "~> 0.2.4"},
      {:ecto, "~> 1.1.2", [override: true]},
      {:joken, "~> 1.2.0"},
      {:poison, "~> 2.1.0"},
      {:mellon, github: "calderalabs/mellon"}
    ]
  end

  # Aliases are shortcut or tasks specific to the current project.
  # For example, to create, migrate and run the seeds file at once:
  #
  #     $ mix ecto.setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    ["ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
     "ecto.reset": ["ecto.drop", "ecto.setup"]]
  end
end

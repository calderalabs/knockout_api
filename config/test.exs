use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :knockout_api, KnockoutApi.Endpoint,
  http: [port: 4001],
  server: false

config :knockout_api,
  api_timeout_in_ms: 30_000,
  api_rate_limit_in_ms: 500

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :knockout_api, KnockoutApi.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "knockout_api_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

  config :rollbax,
    enabled: false,
    access_token: "",
    environment: "test"

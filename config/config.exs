# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :knockout_api, KnockoutApi.Endpoint,
  url: [host: "localhost"],
  root: Path.dirname(__DIR__),
  secret_key_base: "VealOxdELYcm/JqJ1/pcagp9yhbAptR0xqIKQfW8sYQvwCNGkISi5Q4eENFYgtuA",
  render_errors: [accepts: ~w(html json)],
  pubsub: [name: KnockoutApi.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

# Configure phoenix generators
config :phoenix, :generators,
  migration: true,
  binary_id: false

config :plug, :mimes, %{
  "application/vnd.api+json" => ["json-api"]
}

import_config "secret.exs"

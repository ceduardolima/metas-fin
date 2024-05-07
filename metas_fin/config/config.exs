# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :metas_fin,
  ecto_repos: [MetasFin.Repo],
  generators: [timestamp_type: :utc_datetime, binary_id: true]

# Configures the endpoint
config :metas_fin, MetasFinWeb.Endpoint,
  url: [host: "localhost"],
  adapter: Phoenix.Endpoint.Cowboy2Adapter,
  render_errors: [
    formats: [json: MetasFinWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: MetasFin.PubSub,
  live_view: [signing_salt: "xpmPohUQ"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :metas_fin, MetasFin.Profiles.Guardian,
  issuer: "metas_fin",
  secret_key: "ihiMwcC5kOj6xItHXmfJT2hvjatyhqSqTlKBRvp5Dpkz96JvOBE33C8inDiBDFLs"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"

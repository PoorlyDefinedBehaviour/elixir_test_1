# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :chat_2,
  ecto_repos: [Chat2.Repo]

# Configures the endpoint
config :chat_2, Chat2Web.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "o2i6imWSaPzLG5mJ0H+dN8Ndo2bgkRz5PsuaE8fuQU4zD7K8maiiBRvGBzsDoVPR",
  render_errors: [view: Chat2Web.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Chat2.PubSub,
  live_view: [signing_salt: "7X2lWksa"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

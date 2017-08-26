# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :artesanos2017,
  ecto_repos: [Artesanos2017.Repo]

# Configures the endpoint
config :artesanos2017, Artesanos2017Web.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "i/HItWP9YhDG0CM1AHPLXwdZ7rioEGiCM7UCa2+UwonHPoqCGHRgezFA7jeNbTun",
  render_errors: [view: Artesanos2017Web.ErrorView, accepts: ~w(json)],
  pubsub: [name: Artesanos2017.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

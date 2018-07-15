# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

config :data1, :ecto_repos, [Data1.Repo]

config :data1, Data1.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "elixir",
  port:     "5433",
  password: "1potion123",
  database: "conquest",
  hostname: "gtamail.gtaus.com.au"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

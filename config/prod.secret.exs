use Mix.Config

# In this file, we keep production configuration that
# you likely want to automate and keep it away from
# your version control system.
#
# You should document the content of this
# file or create a script for recreating it, since it's
# kept out of version control and might be hard to recover
# or recreate for your teammates (or you later on).
config :events, Events.Endpoint,
  secret_key_base: "LxjEoRk0WACDqCOQ+4xNezm06zT3YclGbyMW1sg2xPu9lnxJogrqUUAPFFR0axER"

# Configure your database
config :events, Events.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "events_prod",
  pool_size: 20

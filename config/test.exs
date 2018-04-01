use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :twitter, TwitterWeb.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :twitter, Twitter.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "twitter_test",
  username: System.get_env("POSTGRES_USER"),
  password: System.get_env("POSTGRES_PASSWORD"),
  hostname: System.get_env("DB_HOST"),
  pool_size: 10
  pool: Ecto.Adapters.SQL.Sandbox

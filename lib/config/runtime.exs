import Config

if Config.config_env() == :dev do
  DotenvParser.load_file(".env")
end

# Now variables from `.env` are loaded into system env
config :excrypt,
  bot_token: System.fetch_env!("BOT_TOKEN")

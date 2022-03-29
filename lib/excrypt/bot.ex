defmodule Excrypt.Bot do
  @bot :excrypt

  use ExGram.Bot,
    name: @bot,
    setup_commands: true

    use Tesla
    plug Tesla.Middleware.BaseUrl, "https://api.coingecko.com/api/v3/"

  # commands of the bot
  command("start")
  command("help", description: "Print the bot's help")
  command("list", description: "List all of the tokens")
  command("ids", description: "List all ids that are supported")
  command("price", description: "List the price of a token")

  # middleware integration
  middleware(ExGram.Middleware.IgnoreUsername)

  @spec bot :: :excrypt
  def bot(), do: @bot

  # bot commands
  def handle({:command, :start, _msg}, context) do
    answer(context, "Hello there! I am up and running.")
  end

  def handle({:command, :help, _msg}, context) do
    answer(context, get_help())
  end

  def handle({:command, :list, _msg}, context) do
    {:ok, response} = get_tokens()
    IO.inspect(response.body)
    answer(context, Jason.decode!(response.body) |> Enum.join("\n"))
  end

  def handle({:command, :ids, _msg}, context) do
    {:ok, response} = get_ids()
    required_symbols = Jason.decode!(response.body) |> Enum.map(fn to -> to["id"] end) |> Enum.take(10)
    answer(context, required_symbols |> Enum.join("\n"))
  end

  def handle({:command, :price, msg}, context) do
    {:ok, response} = get_price(msg.text)
    body = Jason.decode!(response.body)
    answer(context, "The price for #{msg.text} is #{body["bitcoin"]["usd"]}$")
  end

  # fetch the api to get currencies, ids and prices
  def get_tokens do
    get("simple/supported_vs_currencies")
  end

  def get_ids() do
    get("coins")
  end

  def get_price(token_id) do
    get("simple/price?ids=#{token_id}&vs_currencies=usd")
  end

  # boilerplate text/function for the commands
  def get_help() do
    """
    This bot has the following commands
    /start - starts the bot with an introduction
    /list -  list the supported token symbol
    /id - list all supported IDs
    /price - lists the price of a token
    """
  end
end
